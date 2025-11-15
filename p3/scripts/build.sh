#!/bin/sh

k3d cluster create iotcluster --api-port 6443  -p "8888:80@server:0"

kubectl apply -f ../confs/namespaces.yaml

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


kubectl wait --for=condition=ready pods  --all -n argocd --timeout=180s

while true; do
  kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server | grep -i "Running" && break
  echo "Waiting for Argo CD server pod to be ready..."
  sleep 5
done

nohup kubectl port-forward -n argocd svc/argocd-server 8080:443 > /dev/null 2>&1 &
echo "Port forwarding running in the background."
ARGO_PASSWORD=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d)
sleep 3
argocd login localhost:8080 --username admin --password "$ARGO_PASSWORD" --insecure

echo "======================================================"
echo "  ARGO_USER: admin"
echo "  ARGO_PASSWORD: $ARGO_PASSWORD"
echo "  ARGO_URL: https://localhost:8080"
echo "======================================================"

