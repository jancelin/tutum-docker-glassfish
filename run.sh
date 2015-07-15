#!/bin/bash
set -e

asadmin start-domain 
# timezone paris
asadmin --user=admin create-jvm-options "-Duser.timezone=Europe/Paris"
# changement de port
asadmin set configs.config.server-config.network-config.network-listeners.network-listener.http-listener-1.port=80
# deployer les war en stock
cp /home/war/* /opt/glassfish4/glassfish/domains/domain1/autodeploy
# page acceuil
sleep 1m
asadmin set server.http-service.virtual-server.server.default-web-module=home

if [ ! -f /.glassfish_admin_password_changed ]; then
    /change_admin_password.sh
fi
echo "=> Restarting Glassfish server"
asadmin stop-domain
echo "=> Starting and running Glassfish server"
asadmin start-domain -w

