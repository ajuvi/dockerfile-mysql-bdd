FROM mysql:8.0

ENV MYSQL_DATABASE=appdb
ENV MYSQL_ROOT_PASSWORD=toor

COPY data/*.sql /docker-entrypoint-initdb.d/
