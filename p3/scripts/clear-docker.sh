#!/bin/sh

docker container prunei -f

docker image prune -a -f

docker network prune -f

docker volume prune -f

docker system prune --all --volumes -f



