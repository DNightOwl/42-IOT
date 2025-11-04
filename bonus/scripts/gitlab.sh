#!/bin/sh
kubectl create namespace gitlab
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm -rf get_helm.sh
helm repo add gitlab https://charts.gitlab.io/
helm repo update
#helm upgrade --install gitlab gitlab/gitlab -f ../confs/gitlab-values.yaml -n gitlab --timeout 600s
helm upgrade --install gitlab gitlab/gitlab \
-f ../confs/gitlab-variables.yaml \
-n gitlab \
--timeout 600s \
--set gitlabUrl="https://gitlab.com" \
--set runnerRegistrationToken="glrt-485oTIxRC-ZKLReioVB62Wc6MXImNDVpCm86MQp0OjIKdTppbm40Nhg.01.1j1okak3n" \
--set rbac.create=true \
--set runners.privileged=true \
--set certmanager-issuer.email="afilal.lamiaa@gmail.com"
#helm upgrade --install gitlab gitlab/gitlab --namespace gitlab --timeout 600s --set global.host.domain=localhost --set certmanager-issuer.email=user@example.com

#kubectl get secret gitlab-wildcard-tls-ca -ojsonpath='{.data.cfssl_ca}' | base64 --decode > gitlab.localhost.ca.pem
kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -o jsonpath="{.data.password}" | base64 -d && echo
#kubectl port-forwarding service/gitlab-nginx-ingress-controller -n gitlab 8081:80
kubectl port-forward svc/gitlab-webservice-default -n gitlab 8080:8181
kubectl port-forward -n gitlab svc/gitlab-gitlab-shell 2222:22

#example git clone ssh://git@gitlab.localhost:2222/root/laafilal-playground.git

