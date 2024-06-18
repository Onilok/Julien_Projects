FROM mysql:5.7
ENV MYSQL_DATABASE=Bubble
ENV MYSQL_USER=julien
ENV MYSQL_PASSWORD=pass
ENV MYSQL_ROOT_PASSWORD=pass
ADD sql_script.sql /docker-entrypoint-initdb.d
EXPOSE 3306

