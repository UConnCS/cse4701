#!/bin/zsh

CONTAINER_NAME="cse4701-proj1p2"
DATABASE="Book_Loan_DB"
DATABASE_PASSWORD="cse4701"

# Container already created
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    ADDR=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_NAME)
    echo "[-] Container: $CONTAINER_NAME, virtual address: $ADDR"

    # Container already running
    if [ ! "$(docker ps -aq -f status=exited -f name=$CONTAINER_NAME)" ]; then
        echo "[-] Connecting to the containerized SQL instance.."
        mysql -h 127.0.0.1 -u root --password=$DATABASE_PASSWORD $DATABASE
        exit 1
    fi

    # Container currently stopped
    docker start $CONTAINER_NAME
    echo "[-] Container currently offline, booting + connecting.."
    mysql -h 127.0.0.1 -u root --password=$DATABASE_PASSWORD $DATABASE
    exit 1
fi

# Container does not exist on host, create it and connect
docker run -d --name=$CONTAINER_NAME -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$DATABASE_PASSWORD -e MYSQL_USER=user -e MYSQL_PASSWORD=password -e MYSQL_DATABASE=$DATABASE mariadb:10
ADDR=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_NAME)
echo "[-] Container created with virtual address $ADDR"
sleep 2
mysql -h 127.0.0.1 -u root --password=$DATABASE_PASSWORD $DATABASE