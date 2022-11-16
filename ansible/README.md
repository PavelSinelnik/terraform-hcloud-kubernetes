## Prerequisits
# Creds

   Please ensure `ansible/roles/fstab/templates` `.creds` & `.repo_creds` are fullfilled with propper working creds

# Hosts
   Add new node hostname to `ansible/roles/host/tasks/main.yml` file

## CPU Node
1. Ensure static ip is configured via netplan
2. Run ansible playbook (Replace 172.20.41.XX with proper IP & k8s-workerXX with proper hostname)

   `ansible-playbook -i 172.20.41.XX, -u user -k -K -b prepare_host.yml --extra-vars "worker_name=k8s-workerXX kube_version=1.22.5-00 node_type=cpu"`

3. Adopt /etc/hosts file `127.0.1.1` to new hostname `k8s-workerXX`
4. (on the Master Node)

   `kubeadm token create --print-join-command`

5. (on the new Worker Node)

   `kubeadm join ... (see command above)`

6. Pass configured Node to Dima M.


## GPU Node
1. Ensure static ip is configured via netplan
2. Run ansible playbook

   `ansible-playbook -i 172.20.41.xx, -u user -k -K -b prepare_host_gpu.yml --extra-vars "worker_name=k8s-workerXX kube_version=1.22.5-00 node_type=gpu nvidia_driver_version=470"`

2. Adopt /etc/hosts file `127.0.1.1` to new hostname `k8s-workerXX`
3. Rebot to enable nvidia driver

   `sudo reboot`

4. (on the Master Node)

   `kubeadm token create --print-join-command`

5. (on the new Worker Node)

   `kubeadm join ... (see command above)`

6. Add GPU Labels to enable specific daemonsets.

   `kubectl label node k8s-workerXX nvidia.com=gpu nvidia.com/gpu.count=1 nvidia.com/gpu.family=turing nvidia.com/gpu.present=true`

7. Pass configured Node to Dima M.