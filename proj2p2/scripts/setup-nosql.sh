#!/bin/zsh

if [ "$(docker ps -q -f name=cse4701-proj2p2-nosql)" ]; then
    if [ ! "$(docker ps -q -f name=cse4701-proj2p2-nosql -f status=running)" ]; then
        echo "[-] Container currently offline, booting.."
        docker start cse4701-proj2p2-nosql
    fi

    echo "[-] Container is ready."
    sleep 2
    exit 0
fi

echo "[-] Creating container.."
docker run --name cse4701-proj2p2-nosql \
      -p 27017:27017 \
      --platform linux/arm64/v8 \
      -e MONGO_INITDB_ROOT_USERNAME="admin" \
      -e MONGO_INITDB_ROOT_PASSWORD="password" \
      -d mongo-replica-set

sleep 2

echo "[-] Running first-time data generation script.."
ts-node ./scripts/1-generate-mongo.ts
echo "[-] Container is ready."