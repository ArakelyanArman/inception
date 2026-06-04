FROM debian:bookworm

RUN apt-get update && apt-get install -y lsb-release ca-certificates curl && \
    curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    curl \
    mariadb-client \
    ghostscript \
    imagemagick \
    openssl \
    php8.4 \
    php8.4-fpm \
    php8.4-mysql \
    php8.4-curl \
    php8.4-dom \
    php8.4-exif \
    php8.4-igbinary \
    php8.4-imagick \
    php8.4-intl \
    php8.4-mbstring \
    php8.4-xml \
    php8.4-zip \
    php8.4-tokenizer \
    php8.4-common && \
    rm -rf /var/lib/apt/lists/*

RUN cd /usr/local/bin && \
    curl -o wp -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp
COPY tools/wordpress-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/wordpress-entrypoint.sh

ENTRYPOINT [ "wordpress-entrypoint.sh" ]
