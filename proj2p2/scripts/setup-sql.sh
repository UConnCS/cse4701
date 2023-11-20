#!/bin/zsh

# MySQL Setup
CONTAINER_NAME="cse4701-proj2p2-sql"
DATABASE="Book_Loan_DB"
DATABASE_PASSWORD="cse4701"

# Container already created
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    ADDR=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_NAME)
    echo "[-] Container: $CONTAINER_NAME, virtual address: $ADDR"

    # Container already running
    if [ ! "$(docker ps -aq -f status=exited -f name=$CONTAINER_NAME)" ]; then
        echo "[-] Container is ready."
        exit 1
    fi

    # Container currently stopped
    docker start $CONTAINER_NAME
    echo "[-] Container currently offline, booting.."
    exit 1
fi

# Container does not exist on host, create it
docker run -d --name=$CONTAINER_NAME -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$DATABASE_PASSWORD -e MYSQL_USER=user -e MYSQL_PASSWORD=password -e MYSQL_DATABASE=$DATABASE mariadb:10
ADDR=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_NAME)
echo "[-] Container created with virtual address $ADDR"
sleep 5

# Importing data
echo "[-] Importing data.."
mysql -h 127.0.0.1 -u root --password="$DATABASE_PASSWORD" $DATABASE < ./proj1p2.sql
echo "[-] Container is ready."