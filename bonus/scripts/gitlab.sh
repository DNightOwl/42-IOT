#!/bin/sh
kubectl create namespace gitlab
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm -rf get_helm.sh
helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm install gitlab gitlab/gitlab -f ../confs/gitlab-values.yaml -n gitlab --timeout 600s


