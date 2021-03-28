#!/bin/bash

apt-get update
apt-get -qq install git-core software-properties-common python python-setuptools -y
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -qq install -y ansible
echo "[minikube]" | tee -a /etc/ansible/hosts
echo "localhost ansible_connection=local" | tee -a /etc/ansible/hosts
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
# Clone repo with playbooks
git clone --depth 1 https://github.com/g3rhard/ansible-minikube-test.git
# Ansible-galaxy
ansible-galaxy install -r ansible-minikube-test/requirements.yml
ansible-playbook ansible-minikube-test/provision.yaml
# Add user ubntu to group docker
usermod -aG docker ubuntu
echo > /tmp/provision.finished
