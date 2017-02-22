#!/bin/bash
#Updating packages and adding new repository
apt-get update
apt-get upgrade -y
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list
apt-get update
#Installing kubernetes and docker engine
apt-get install -y kubelet nfs-common kubeadm kubectl kubernetes-cni docker-engine
