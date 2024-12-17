#!/bin/bash

# Script to install Kubernetes (kubeadm, kubelet, and kubectl) on Ubuntu

# Step 1: Update the system and install required packages
echo "[Step 1] Updating system and installing required packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y apt-transport-https ca-certificates curl

# Step 2: Install container runtime (Docker)
echo "[Step 2] Installing Docker..."
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

# Step 3: Disable swap (required for Kubernetes)
echo "[Step 3] Disabling swap..."
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

# Step 4: Add Kubernetes APT repository
echo "[Step 4] Adding Kubernetes repository..."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Step 5: Install kubeadm, kubelet, and kubectl
echo "[Step 5] Installing kubeadm, kubelet, and kubectl..."
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl  # Prevent automatic updates

# Step 6: Enable and start kubelet
echo "[Step 6] Enabling and starting kubelet..."
sudo systemctl enable kubelet
sudo systemctl start kubelet

# Step 7: Print installation status
echo "Kubernetes installation complete!"
echo "You can now initialize your cluster with 'sudo kubeadm init'."
