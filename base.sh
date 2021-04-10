#!/bin/bash

# Base
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get -qq install git-core software-properties-common python python-setuptools -y
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get -qq install -y ansible
