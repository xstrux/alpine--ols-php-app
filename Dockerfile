FROM phpearth/php:7.3-litespeed

MAINTAINER "ihsanberahim" <ihsanberahim@gmail.com>

ARG HOSTNAME

ADD start-lsws.sh /start-lsws.sh

#Install supervisor
RUN apk add --update supervisor
ADD supervisord.conf /supervisord.conf

#Install Composer
RUN apk add --no-cache composer
RUN composer self-update
RUN composer --version

#Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN wp --version --allow-root

#Setting Up
RUN rm -rf /var/lib/litespeed/Example
RUN mkdir -p /var/lib/litespeed/web
RUN mkdir -p /var/lib/litespeed/web/logs/
COPY var/lib/litespeed/web/ /var/lib/litespeed/web/
RUN chown -R nobody:nobody /var/lib/litespeed/web/

RUN rm -rf /etc/litespeed/vhosts/Example
COPY var/lib/litespeed/conf/vhosts/web/ /etc/litespeed/vhosts/web/
RUN chown -R lsadm:lsadm /etc/litespeed/vhosts/web/

RUN rm -f /etc/litespeed/httpd_config.conf
COPY var/lib/litespeed/conf/httpd_config.conf /etc/litespeed/httpd_config.conf
RUN chown lsadm:lsadm /etc/litespeed/httpd_config.conf

CMD ["/bin/sh", "-c", "cd /var/lib/litespeed/web/"]

ENTRYPOINT ["/bin/sh", "/start-lsws.sh"]