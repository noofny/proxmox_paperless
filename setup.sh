#!/bin/bash

# timezone...
sudo timedatectl set-timezone Australia/Sydney

# packages...
sudo apt install -y qemu-guest-agent

# patch...
sudo apt update && sudo apt upgrade

# user/groups...
passwd
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
sudo snap disable docker
sudo snap enable docker

# misc...
echo "alias ls='ls -lha'" >> ~/.bashrc
source ~/.bashrc

# restart...
sudo reboot now
