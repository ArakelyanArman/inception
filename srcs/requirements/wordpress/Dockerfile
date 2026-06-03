# Use Debian Bookworm slim
FROM debian:bookworm-slim

# Install system dependencies, PHP 8.2, and extensions
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    bash \
    curl \
    mariadb-client \
    ghostscript \
    imagemagick \
    openssl \
    ca-certificates \
    php8.2-fpm \
    php8.2-cli \
    php8.2-curl \
    php8.2-dom \
    php8.2-exif \
    php8.2-fileinfo \
    php8.2-igbinary \
    php8.2-imagick \
    php8.2-intl \
    php8.2-mbstring \
    php8.2-mysql \
    php8.2-xml \
    php8.2-zip \
    php8.2-opcache \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -o /usr/local/bin/wp -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp

# Copy the executable script for WordPress configuration
COPY tools/wordpress-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress-entrypoint.sh

ENTRYPOINT [ "wordpress-entrypoint.sh" ]
