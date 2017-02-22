#!/bin/bash
#Updating packages and adding new repository
apt-get update
apt-get upgrade -y
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list
apt-get update
#Installing kubernetes and docker engine
apt-get install -y kubelet nfs-common kubeadm kubectl kubernetes-cni docker-engine git
#comment kubeadm reset if you wil create a new cluster without erase the actual cluster
#kubeadm reset all cluster if someone exist
kubeadm reset
#Creating new cluster
kubeadm init 
#Getting secret token to join into the cluster
#To get a minion run this command kubeadm join --token=$tokenid  $privateinstanceip
#kubectl -n kube-system get secret clusterinfo -o yaml | grep token-map | awk '{print $2}' | base64 -d | sed "s|{||g;s|}||g;s|:|.|g;s/\"//g;" | xargs echo
#Installing feature for CNI
kubectl apply -f https://git.io/weave-kube
#Creating namespace
kubectl create namespace devops
#Adding services
cd services/
bash addservices.sh
cd ..
#Adding Pods
cd pods/
bash addpods.sh


echo "Run kubectl get svc,pods -n devops to see the containers"
