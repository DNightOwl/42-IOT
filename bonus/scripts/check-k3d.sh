#!/bin/sh


echo "k3d cluster list"
k3d cluster list

echo "k3d nodes"

kubectl get nodes

echo "k3d namespaces"

kubectl get namespaces


