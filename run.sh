#!/bin/bash



set -e

asadmin start-domain 
# timezone paris
asadmin --user=admin create-jvm-options "-Duser.timezone=Europe/Paris"
# changement de port
asadmin set server.http-service.http-listener.http-listener-1.port=80

if [ ! -f /.glassfish_admin_password_changed ]; then
    /change_admin_password.sh
    
fi
echo "=> Restarting Glassfish server"
asadmin stop-domain
echo "=> Starting and running Glassfish server"
asadmin start-domain -w

