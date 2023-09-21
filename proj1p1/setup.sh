#!/bin/zsh
# Container already created
if [ "$(docker ps -q -f name=cse4701-sql)" ]; then
    ADDR=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cse4701-sql)

    # Container already running
    if [ ! "$(docker ps -aq -f status=exited -f name=cse4701-sql)" ]; then
        echo "[-] Connecting.."
        mysql -h 127.0.0.1 -u root -p cse4701
        exit 1
    fi

    # Container currently stopped
    docker start cse4701-sql
    echo "[-] Container started with virtual address $ADDR"
    mysql -h 127.0.0.1 -u root -p cse4701
    exit 1
fi

# Container does not exist on host, create it and connect
docker run -d --name=cse4701-sql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=cse4701 -e MYSQL_USER=user -e MYSQL_PASSWORD=password -e MYSQL_DATABASE=cse4701 mariadb:10
ADDR=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cse4701-sql)
echo "[-] Container created with virtual address $ADDR"
sleep 2
mysql -h 127.0.0.1 -u root -p cse4701