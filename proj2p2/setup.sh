#!/bin/zsh

if [[ "$(docker images -q mongo-replica-set 2> /dev/null)" == "" ]]; then
    echo "[*] Building mongo docker image"
    docker build -t mongo-replica-set .
fi

for file in ./scripts/setup-*; do
    file_name=$(basename $file .sh)
    echo "[*] Running setup flow: $file_name"
    zsh $file
done
