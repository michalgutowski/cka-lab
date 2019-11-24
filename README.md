# virtualbox lab environment for LFS258 Kubernetes Fundamentals training and practicing for CKA exams

Two Ubuntu (Xenial) VMs - master and worker

K8s networking:
Internal IPs: 
  192.168.56.101 (master)
  192.168.56.102 (worker)
Pod CIDR: 10.244.0.0/16 (with Calico)

## Notes
Nodes are ready for k8s installation with kubeadm using kubeadm-config.yaml file

Passwordless ssh between nodes using root user

User student password: welcome1
