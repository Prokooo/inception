FROM debian:12.1

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY entrypoint.sh /entrypoint.sh

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

RUN chmod +x ./entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["./entrypoint.sh"]