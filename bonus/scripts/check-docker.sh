#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'
BOLD='\033[1m'
N='\033[0m'

#====================
echo "\n${GREEN} Docker Version =================================================================\n${NC}"
docker version
echo "\n${GREEN} Docker Containers (running and stopped)=========================================\n${NC}"
docker ps -a
echo "\n${GREEN} Docker Images ==================================================================\n${NC}"
docker images -a
echo "\n${GREEN} Docker Volumes =================================================================\n${NC}"
docker volume ls
echo "\n${GREEN} Docker Network =================================================================\n${NC}"
docker network ls
echo "\n${GREEN}=================================================================================\n${NC}"


