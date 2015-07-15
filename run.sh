#!/bin/bash



set -e

asadmin start-domain 
if [ ! -f /.glassfish_admin_password_changed ]; then
    /change_admin_password.sh
    asadmin --user=admin create-jvm-options "-Duser.timezone=Europe/Paris"
fi
echo "=> Restarting Glassfish server"
asadmin stop-domain
echo "=> Starting and running Glassfish server"
asadmin start-domain -w

