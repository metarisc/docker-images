FROM php:8.2-cli-alpine

# Install base packages
RUN apk add --no-cache \
    icu-dev \
    supervisor

# PHP Global Extensions
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install opcache
RUN docker-php-ext-install intl

# PHP Utils
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# Configure PHP
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY server/php_core.ini $PHP_INI_DIR/conf.d/core.ini
COPY server/php_date.ini $PHP_INI_DIR/conf.d/date.ini
COPY server/php_opcache.ini $PHP_INI_DIR/conf.d/opcache.ini

# PHP Postgresql Database Extensions
RUN apk add --no-cache postgresql-dev \
    && docker-php-ext-configure pgsql --with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pgsql \
    && docker-php-ext-install pdo_pgsql

# PHP SQLite Database Extensions
RUN apk add --no-cache sqlite \
    && install-php-extensions pdo_sqlite \
    && apk del sqlite

# PHP MySQL Database Extensions
RUN install-php-extensions pdo_mysql

# Make sure files/folders needed by the processes are accessible when they run under the www-data user
RUN chown -R www-data:www-data /var/www/html /run

# Setup Docker entrypoint (initialize container service)
COPY docker-entrypoint.sh /usr/local/bin/docker-metarisc-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-metarisc-entrypoint.sh
COPY /docker-entrypoint.d/* /docker-entrypoint.d/
ONBUILD COPY /docker-entrypoint.d*/* /docker-entrypoint.d/
ENTRYPOINT ["docker-metarisc-entrypoint.sh"]