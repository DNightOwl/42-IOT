#!/bin/sh
#
#


kubectl apply -f ../confs/ingress.yaml
kubectl apply -f ../confs/application.yaml
sleep 4

kubectl wait --for=condition=ready pods --all -n dev --timeout=300s

echo "======================================================"
echo "  DEV_URL: http://localhost:8888"
echo "======================================================"
echo " git@github.com:DNightOwl/laafilal-IOT-config.git "
echo "======================================================"

