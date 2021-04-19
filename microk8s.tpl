#!/bin/bash

set -e

SERVER="microk8s"

# Clone repo with playbooks
git clone --depth 1 https://github.com/g3rhard/terraform-ansible-provision.git >> /tmp/provision.log 2>&1
# Define Host
echo "[$SERVER]" | tee -a /etc/ansible/hosts
echo "localhost ansible_connection=local" | tee -a /etc/ansible/hosts

# Ansible-galaxy
ansible-galaxy install -r "terraform-ansible-provision/$SERVER/requirements.yml" >> /tmp/provision.log 2>&1
ansible-playbook "terraform-ansible-provision/$SERVER/provision.yaml" >> /tmp/provision.log 2>&1

snap install microk8s --classic --channel=1.21 >> /tmp/provision.log 2>&1
usermod -a -G microk8s ubuntu
mkdir /home/ubuntu/.kube
chown -f -R ubuntu /home/ubuntu/.kube

curl -sS https://webinstall.dev/k9s | bash >> /tmp/provision.log 2>&1

echo > /tmp/provision.finished
