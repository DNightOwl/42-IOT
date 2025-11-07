#!/bin/sh
#
#sudo k3d cluster create iotcluster
#curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
#chmod 700 get_helm.sh
#./get_helm.sh
#rm -rf get_helm.sh

#sudo kubectl create namespace gitlab
# TODO: should be run before argocd
#
#
helm repo add gitlab http://charts.gitlab.io/

spleep 3

helm repo update

helm upgrade --install gitlab gitlab/gitlab -n gitlab -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml --set global.hosts.domain=localhost.com --set global.hosts.externalIP=0.0.0.0 --set global.hosts.https=false --timeout 600s

#add it to /etc/hosts 127.0.0.1 gitlab.localhost.com
#ssh -T -p 32022 git@gitlab.localhost.com
#Welcome to GitLab, @root!


kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -o jsonpath="{.data.password}" | base64 -d && echo


nohup kubectl port-forward svc/gitlab-webservice-default -n gitlab 80:8181 > /dev/null 2>&1 &

nohup kubectl port-forward -n gitlab svc/gitlab-gitlab-shell 32022:32022 > /dev/null 2>&1 &


#========>git clone  ssh://git@gitlab.localhost.com:32022/root/laafilal-playground.git

#kubectl port-forward svc/gitlab-webservice-default -n gitlab 80:8181


#sudo git clone http://gitlab.gitlab.example.com/root/laafilal-playground.git


#sudo git clone ssh://gitlab.example.com:32022/root/laafilal-playground.git laafilal-playground2
