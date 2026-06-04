FROM debian:bookworm

RUN apt-get update && apt-get install mariadb-server mariadb-client bash -y

COPY tools/mariadb-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb-entrypoint.sh

ENTRYPOINT [ "mariadb-entrypoint.sh" ]
