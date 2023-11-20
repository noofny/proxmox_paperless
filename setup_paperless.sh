#!/bin/bash


echo "Setup Paperless : begin"


# locale
echo "Fixing locale..."
LOCALE_VALUE="en_AU.UTF-8"
locale-gen ${LOCALE_VALUE}
source /etc/default/locale
update-locale ${LOCALE_VALUE}


echo "Creating folders..."
mkdir -p /home/docsadmin/paperless/broker
mkdir -p /home/docsadmin/paperless/db


echo "Creating stack..."
mv /docker-compose.yaml /home/docsadmin/docker-compose.yaml
cd /home/docsadmin
docker-compose pull
echo "Starting stack..."
docker-compose up --detach


echo "Connecting to the web container and setup your user..."
echo " > docker exec -it docsadmin_webserver_1 bash"
echo " > python manage.py createsuperuser"
echo "Follow the prompts and then exit."
echo "You can access the console at http://$(hostname -I):8000/"
echo "Setup Paperless : complete"
