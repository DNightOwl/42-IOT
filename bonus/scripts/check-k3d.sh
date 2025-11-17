#!/bin/sh


if command -v k3d > /dev/null 2>&1; then
	k3d version
	echo "k3d cluster list"
	k3d cluster list
	clusters=$(k3d cluster list | awk 'NR>1 {print $1}')
	if ! [ -z "$clusters" ]; then

		echo "k3d nodes"

		kubectl get nodes

		echo "k3d namespaces"

		kubectl get namespaces
	else
		echo "No k3d cluster found"
	fi
else
	echo "k3d is not installed"
fi

