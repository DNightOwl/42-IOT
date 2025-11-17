#!/bin/sh

k3d cluster create iotcluster --api-port 6443  -p "8888:80@server:0"

kubectl apply -f ../confs/namespaces.yaml

if ! grep -q 'gitlab.localhost.com' /etc/hosts
then
	sudo sed -i '1i 127.0.0.1 gitlab.localhost.com' /etc/hosts
fi

helm repo add gitlab http://charts.gitlab.io/
sleep 3

helm repo update
sleep 2
helm upgrade --install gitlab gitlab/gitlab -n gitlab -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml --set global.hosts.domain=localhost.com --set global.hosts.externalIP=0.0.0.0 --set global.hosts.https=false --timeout 600s
echo "Waiting for GitLab server pods to be ready..."
while true; do
  # Get the total number of pods and the number of running pods
  total_pods=$(kubectl get pods -n gitlab --no-headers | wc -l)
  running_pods=$(kubectl get pods -n gitlab --no-headers | grep -iE "Running|Completed" | wc -l)

  # If the number of running pods is equal to the total number of pods, exit
  if [ "$total_pods" -eq "$running_pods" ]; then
    echo "All GitLab server pods are running."
    break
  fi

  #echo "Waiting for GitLab server pods to be ready..."
  sleep 5
done

kubectl wait --for=condition=ready pods  --all -n gitlab --timeout=200s


nohup kubectl port-forward svc/gitlab-webservice-default -n gitlab 8080:8181   > /dev/null 2>&1 & 

nohup kubectl port-forward -n gitlab svc/gitlab-gitlab-shell 32022:32022  > /dev/null 2>&1 &



kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sleep 3
#kubectl rollout restart deployment -n argocd


kubectl wait --for=condition=ready pods  --all -n argocd --timeout=300s
#kubectl wait --for=condition=ready pods -l app.kubernetes.io/name=argocd-server  -n argocd --timeout=180s
while true; do
  kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server | grep -i "Running" && break
  echo "Waiting for Argo CD server pod to be ready..."
  sleep 5
done

nohup kubectl port-forward -n argocd svc/argocd-server 8081:443  > /dev/null 2>&1 &


GITLAB_PASSWORD=$(kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -o jsonpath="{.data.password}" | base64 -d)
ARGO_PASSWORD=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d)
sleep 3
argocd login localhost:8081 --username admin --password "$ARGO_PASSWORD" --insecure
sleep 3

SSH_KEY=$(eval echo $HOME/.ssh/id_*.pub)
echo "======================================================"
echo "	ARGO_USER: admin"
echo "	ARGO_PASSWORD: $ARGO_PASSWORD"
echo "  ARGO_URL: https://localhost:8081"
echo "======================================================"
echo "	GITLAB_USER: root"
echo "	GITLAB_PASSWORD: $GITLAB_PASSWORD"
echo "  GITLAB_URL: http://gitlab.localhost.com:8080"
echo "======================================================"
echo "	Add your ssh key to your local gitlab account"
echo "	SSH KEY: "
sudo cat "$SSH_KEY"
echo "======================================================"
echo "git@github.com:DNightOwl/laafilal-IOT-config"
echo "======================================================"

