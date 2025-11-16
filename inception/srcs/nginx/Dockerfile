FROM debian:12.1

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

COPY conf/default /etc/nginx/sites-available/default

COPY bash.sh /bash.sh

RUN chmod 755 /bash.sh

EXPOSE	443

CMD ["/bash.sh"]
