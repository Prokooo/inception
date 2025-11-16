FROM debian:12.1

RUN apt-get update && \
    apt-get install -y \
        php8.2-fpm php8.2-mysql mariadb-client php-cli php-curl php-gd php-mbstring php-xml php-xmlrpc php-zip wget unzip && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html


RUN wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz \
    && tar -xvzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm /tmp/wordpress.tar.gz


RUN chown -R root:root /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp


COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf


COPY auto_config.sh /auto_config.sh
RUN chmod +x /auto_config.sh

RUN mkdir -p /run/php

EXPOSE 9000

ENTRYPOINT ["/auto_config.sh"]
