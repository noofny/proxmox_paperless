#!/bin/bash


echo "Setup Paperless : begin"


# locale
echo "Fixing locale..."
LOCALE_VALUE="en_AU.UTF-8"
locale-gen ${LOCALE_VALUE}
source /etc/default/locale
update-locale ${LOCALE_VALUE}
sed -e '/SendEnv/ s/^#*/#/' -i /etc/ssh/ssh_config


# # user/groups...
# passwd
# sudo addgroup --system docker
# sudo adduser $USER docker
# newgrp docker
# sudo snap disable docker
# sudo snap enable docker


echo "Creating folders..."
mkdir -p /home/docsadmin/paperless/broker
mkdir -p /home/docsadmin/paperless/db


echo "Creating stack..."
mv /docker-compose.yaml /home/docsadmin/docker-compose.yaml
cd /home/docsadmin
docker-compose pull
echo "Creating user..."
docker-compose run --rm webserver createsuperuser
echo "Starting stack..."
docker-compose up --detach


# echo "Connecting to container to setup user..."
# echo "NOTE: once connected to interactive session run 'python manage.py createsuperuser', follow prompts, then exit"
# docker exec -it paperless-webserver-1 bash


echo "You can access the console at http://$(hostname -I):8000/"
echo "Setup Paperless : complete"
