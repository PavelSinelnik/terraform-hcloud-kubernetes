#!/bin/bash


until $(nc -z ${floating_ip_address} 6443); do
  echo "Waiting for API server to respond"
  sleep 5
done

token=$(cat /tmp/kubeadm_token)

sudo kubeadm join --token=$${token} ${floating_ip_address}:6443 \
  --discovery-token-unsafe-skip-ca-verification \
  --ignore-preflight-errors=Swap
