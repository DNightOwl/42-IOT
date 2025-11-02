#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'
BOLD='\033[1m'
N='\033[0m'

#====================

echo "\n${GREEN} Installing k3d =================================================================\n${NC}"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
echo "\n${GREEN} Installing kubctrl =============================================================\n${NC}"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl
rm kubectl

echo "\n${GREEN} Installing argocd =============================================================\n${NC}"
sleep 5
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sleep 5
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
sleep 5
rm argocd-linux-amd64

echo "\n${GREEN} Done ===========================================================================\n${NC}"

