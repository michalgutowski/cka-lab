#!/bin/sh

# Install haproxy and nfs server
apt install -y haproxy nfs-kernel-server

# Configure and enable haproxy
cp -b /vagrant/haproxy/haproxy.cfg /etc/haproxy/
systemctl start haproxy
systemctl enable haproxy

# Configure NFS server for persistent volume labs
mkdir /opt/sfw
chmod a+rwt /opt/sfw
printf 'software' > /opt/sfw/hello.txt
printf '/opt/sfw *(rw,no_root_squash,async,no_subtree_check,insecure)\n' > /etc/exports
systemctl start nfs-kernel-server
systemctl enable nfs-kernel-server

