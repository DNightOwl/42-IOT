#!/bin/sh
#

sudo apt-get update 
sudo apt-get  install -y git curl openssh-server vim

#installing docker
curl -fsSL https://get.docker.com -o get-docker.sh
sleep 3
sudo sh get-docker.sh
sleep 3
sudo usermod -aG docker $USER
rm get-docker.sh
echo "${GREEN}====================================================================================================${NC}"
echo "${GREEN}ℹ️  => Please use the command ${BOLD}'newgrp docker'${N}${GREEN} to finish the Docker env setting up]${NC}"
echo "${GREEN}====================================================================================================${NC}"
#installing k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

#installing kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl
rm kubectl

#inctall argocd
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sleep 3
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
sleep 3
rm argocd-linux-amd64

#installing helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm -rf get_helm.sh


curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
rm get-docker.sh

