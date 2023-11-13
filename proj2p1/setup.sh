if [ "$(docker ps -q -f name=cse4701-proj2p1)" ]; then
    if [ ! "$(docker ps -q -f name=cse4701-proj2p1 -f status=running)" ]; then
        echo "[-] Container currently offline, booting.."
        docker start cse4701-proj2p1
    fi

    echo "[-] Container is ready."
    sleep 2
    exit 0
fi

echo "[-] Creating container.."
docker run --name cse4701-proj2p1 \
      -p 27017:27017 \
      --platform linux/arm64/v8 \
      -e MONGO_INITDB_ROOT_USERNAME="admin" \
      -e MONGO_INITDB_ROOT_PASSWORD="password" \
      -d mongo-replica-set

sleep 2