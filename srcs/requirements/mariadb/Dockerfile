FROM debian:bookworm-slim

# DEBIAN_FRONTEND=noninteractive prevents apt from halting the build for user inputs
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    mariadb-server \
    mariadb-client \
    galera-4 \
    && rm -rf /var/lib/apt/lists/*

COPY tools/mariadb-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb-entrypoint.sh

ENTRYPOINT [ "mariadb-entrypoint.sh" ]
