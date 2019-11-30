#!/bin/sh

# set up hosts file
cat <<-EOF >>/etc/hosts
192.168.56.100 ckalb
192.168.56.101 ckamaster1 ckamaster
192.168.56.102 ckamaster2
192.168.56.103 ckamaster3
192.168.56.104 ckaworker1
EOF

# allow root ssh logins
printf '\nPermitRootLogin yes\n' >> /etc/ssh/sshd_config
printf '\nStrictHostKeyChecking no\n' >>/etc/ssh/ssh_config
systemctl restart sshd

# Make a student sudo user with password welcome1
useradd student -m -p '$6$UhZjFYH1$9RiEbku8QFfIiKq0mf5spCHABaAK218nbH/c3ISzc63v5VRmM/2aUSRpsq3IAJ025.yXbOSJPCpr.VsgG.g3o.' -s /bin/bash
mkdir -p /home/student/.ssh
cp /vagrant/id_rsa /home/student/.ssh/
cp /vagrant/id_rsa.pub /home/student/.ssh/authorized_keys
chmod 0644 /home/student/.ssh/authorized_keys
printf 'student ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/student
chmod 440 /etc/sudoers.d/student

# swap no allowed
swapoff -a

# allow ssh between nodes
cp /vagrant/id_rsa /root/.ssh
cp /vagrant/id_rsa.pub /root/.ssh/authorized_keys
chmod 0600 /root/.ssh/*

# Fix locale
locale-gen "en_US.UTF-8"
update-locale LC_ALL="en_US.UTF-8"

# Import key and add k8s apt repo
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Copy initial kubadm and calico config yaml files
cp /vagrant/kubernetes/kubeadm-config.yaml /root/kubeadm-config.yaml
cp /vagrant/kubernetes/calico.yaml /vagrant/kubernetes/rbac-kdd.yaml /home/student/

# Update, upgrade and instal nfs client tools
apt-get update && apt-get upgrade -y && apt-get install -y nfs-common
