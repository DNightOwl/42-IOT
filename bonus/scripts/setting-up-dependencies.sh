#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'
BOLD='\033[1m'
N='\033[0m'


sudo apt update -y
sudo apt install -y git  
sudo git config --global user.name "laafilal"
sudo git config --global user.email "laafilal@student.1337.ma"

curl -fsSL https://get.docker.com -o get-docker.sh 
sudo sh get-docker.sh
sudo usermod -aG docker $USER
rm get-docker.sh
echo "${GREEN}=================================================================================${NC}"
echo "${GREEN}ℹ️  => Please use the command ${BOLD}'newgrp docker'${N}${GREEN} to finish the Docker env setting up]${NC}"
echo "${GREEN}=================================================================================${NC}"

