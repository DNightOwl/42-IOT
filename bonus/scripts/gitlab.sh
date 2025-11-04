#!/bin/sh
kubectl create namespace gitlab
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm -rf get_helm.sh
helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm upgrade --install gitlab gitlab/gitlab -f ../confs/gitlab-values.yaml -n gitlab --timeout 600s

#helm upgrade --install gitlab gitlab/gitlab --namespace gitlab --timeout 600s --set global.host.domain=localhost --set certmanager-issuer.email=user@example.com

kubectl port-forwarding service/gitlab-nginx-ingress-controller -n gitlab 8081:80


