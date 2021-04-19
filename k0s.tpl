#!/bin/bash

set -e

SERVER="k0s"

# Clone repo with playbooks
git clone --depth 1 https://github.com/g3rhard/terraform-ansible-provision.git >> /tmp/provision.log 2>&1
# Define Host
echo "[$SERVER]" | tee -a /etc/ansible/hosts
echo "localhost ansible_connection=local" | tee -a /etc/ansible/hosts

# Ansible-galaxy
ansible-galaxy install -r "terraform-ansible-provision/$SERVER/requirements.yml" >> /tmp/provision.log 2>&1
ansible-playbook "terraform-ansible-provision/$SERVER/provision.yaml" >> /tmp/provision.log 2>&1

curl -sSLf https://get.k0s.sh | sh >> /tmp/provision.log 2>&1
k0s install controller --single >> /tmp/provision.log 2>&1
systemctl start k0scontroller >> /tmp/provision.log 2>&1
systemctl enable k0scontroller >> /tmp/provision.log 2>&1

curl -sS https://webinstall.dev/k9s | bash >> /tmp/provision.log 2>&1

echo > /tmp/provision.finished
