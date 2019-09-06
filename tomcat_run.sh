#!/bin/bash

if [ ! -f /script/.tomcat_admin_created ];then
    /script/create_tomcat_admin_user.sh
fi

/usr/sbin/sshd -D &
exec ${CATALINA_HOME}/bin/catalina.sh run
