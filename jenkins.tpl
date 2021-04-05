#!/bin/bash

SERVER="jenkins"

# Shared Part
apt-get update
apt-get -qq install git-core software-properties-common python python-setuptools -y
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -qq install -y ansible

# Clone repo with playbooks
git clone --depth 1 https://github.com/g3rhard/terraform-ansible-provision.git
# Define Host
echo "[$SERVER]" | tee -a /etc/ansible/hosts
echo "localhost ansible_connection=local" | tee -a /etc/ansible/hosts

# Ansible-galaxy
ansible-galaxy install -r "terraform-ansible-provision/$SERVER/requirements.yml"
ansible-playbook "terraform-ansible-provision/$SERVER/provision.yaml"

echo > /tmp/provision.finished
