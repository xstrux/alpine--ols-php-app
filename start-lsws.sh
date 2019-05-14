echo 'Changing port to...'
echo ${PORT}

if test -n ${PORT}
then    
    cp /etc/litespeed/httpd_config.conf /etc/litespeed/httpd_config.conf.bak
    sed -e "s/*:80/*:${PORT}/" /etc/litespeed/httpd_config.conf.bak > /etc/litespeed/httpd_config.conf
    echo 'Port successfully changed'
else
    echo 'no variable PORT been set'
fi

/var/lib/litespeed/bin/lswsctrl start
/usr/bin/supervisord -n -c /supervisord.conf