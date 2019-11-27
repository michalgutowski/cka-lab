#!/bin/sh

# Install haproxy
apt install -y haproxy

# Configure and enable haproxy
cp -b /vagrant/haproxy/haproxy.cfg /etc/haproxy/
systemctl start haproxy
systemctl enable haproxy
