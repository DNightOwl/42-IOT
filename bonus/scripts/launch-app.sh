#!/bin/sh
#
#

echo "Please enter the repo name:"
read repo

export REPO=$repo

if grep -q '${REPO}' ../confs/application.yaml
then
	sed -i "s|\${REPO}|$REPO|g" ../confs/application.yaml
fi
kubectl apply -f ../confs/ingress.yaml
kubectl apply -f ../confs/application.yaml
sleep 2
kubectl wait --for=condition=ready pods --all -n dev --timeout=300s

echo "======================================================"
echo "  DEV_URL: http://localhost:8888"
echo "======================================================"


#print the dev info , url ...
