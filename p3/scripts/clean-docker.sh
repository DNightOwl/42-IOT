#!/bin/sh

echo "Pruning Docker Containers..."
docker container prune -f

echo "Pruning Docker Images..."
docker image prune -a -f

echo "Pruning Docker Networks..."
docker network prune -f

echo "Pruning Docker Volumes..."
docker volume prune -f

echo "Pruning Docker System (including all unused resources)..."
docker system prune --all --volumes -f

echo "Docker Pruning Completed!"


