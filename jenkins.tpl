#!/bin/bash

sudo apt update -qq
apt-get -qq install software-properties-common -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt update -qq
apt install -y default-jre
apt install -y jenkins
systemctl start jenkins
