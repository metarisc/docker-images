FROM php:8.2-fpm-alpine

# Install base packages
RUN apk add --no-cache \
    icu-dev \
    nginx \
    envsubst \
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

# Configure supervisord
COPY server/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

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

# Configure PHP-FPM
RUN rm /usr/local/etc/php-fpm.d/docker.conf
RUN rm /usr/local/etc/php-fpm.d/zz-docker.conf
RUN rm /usr/local/etc/php-fpm.d/www.conf.default
COPY server/fpm.conf /usr/local/etc/php-fpm.d/www.conf

# Configure HTTP server : NGINX
ENV PORT=8000
COPY server/nginx_config.conf /etc/nginx/nginx.conf
COPY server/nginx_server.conf /etc/nginx/conf.d/default_template.conf
RUN envsubst '${PORT}' < /etc/nginx/conf.d/default_template.conf > /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/conf.d/default_template.conf

# Make sure files/folders needed by the processes are accessible when they run under the www-data user
RUN chown -R www-data:www-data /var/www/html /run /var/lib/nginx /var/log/nginx

# Configure a healthcheck to validate that everything is up & running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:${PORT}/fpm-ping

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Setup Docker entrypoint (initialize container service)
COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh
COPY /docker-entrypoint.d/* /docker-entrypoint.d/
ONBUILD COPY /docker-entrypoint.d/* /docker-entrypoint.d/
ENTRYPOINT ["./docker-entrypoint.sh"]