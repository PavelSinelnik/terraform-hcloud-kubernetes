#!/bin/bash

sudo kubeadm init \
  --pod-network-cidr=10.244.0.0/16 \
  --ignore-preflight-errors=all \
  --apiserver-advertise-address=${floating_ip_address} \
  --control-plane-endpoint=${floating_ip_address} 

# Configure kubectl to connect to the kube-apiserver
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

until nc -z localhost 6443; do
  echo "Waiting for API server to respond"
  sleep 5
done

# patch tollerations for coredns
kubectl -n kube-system patch deployment coredns --type json -p '[{"op":"add","path":"/spec/template/spec/tolerations/-","value":{"key":"node.cloudprovider.kubernetes.io/uninitialized","value":"true","effect":"NoSchedule"}}]'

# deploy the flannel CNI plugin
kubectl apply -f /tmp/kube-flannel.yaml

# Patch the flannel deployment to tolerate the uninitialized taint
kubectl -n kube-flannel patch ds kube-flannel-ds --type json -p '[{"op":"add","path":"/spec/template/spec/tolerations/-","value":{"key":"node.cloudprovider.kubernetes.io/uninitialized","value":"true","effect":"NoSchedule"}}]'

# deploy the Hetzner Cloud controller manager
kubectl apply -n kube-system -f /tmp/ccm-networks.yaml

# deploy the Hetzner Cloud Container Storage Interface
# kubectl apply -f /tmp/hcloud-csi.yaml
