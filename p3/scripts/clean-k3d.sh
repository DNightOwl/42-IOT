#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'
BOLD='\033[1m'
N='\033[0m'

#====================

echo "🧹 Starting k3d uninstallation..."

# Delete all clusters
echo "📦 Deleting all k3d clusters..."
k3d cluster delete --all

# Remove k3d binary
if command -v k3d &> /dev/null; then
    echo "🗑️ Removing k3d binary..."
    sudo rm -f /usr/local/bin/k3d
fi

# Remove config and data
echo "📁 Removing k3d configuration..."
rm -rf ~/.k3d
rm -rf ~/.config/k3d

# Remove kubeconfig entries
echo "🔧 Cleaning up kubeconfig..."
kubectl config delete-context k3d-iotcluster 2>/dev/null || true
kubectl config delete-cluster k3d-iotcluster 2>/dev/null || true
kubectl config unset users.k3d-iotcluster 2>/dev/null || true

echo "✅ k3d uninstallation completed!"

