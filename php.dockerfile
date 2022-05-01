FROM php:7.4-fpm-alpine

RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql

RUN docker-php-ext-install opcache

RUN apk add --no-cache zip libzip-dev

RUN docker-php-ext-configure zip

RUN docker-php-ext-install zip

RUN apk add --no-cache \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        freetype-dev

RUN docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype
RUN docker-php-ext-install gd

RUN docker-php-ext-install exif

RUN apk add --update --no-cache autoconf g++ libtool make pcre-dev imagemagick-dev imagemagick \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del autoconf libtool make pcre-dev

RUN apk add icu-dev

RUN docker-php-ext-configure intl && docker-php-ext-install intl

COPY ./nginx/certs/mkcert_development_CA_184190932158314348491736270304619014522.crt /usr/local/share/ca-certificates
RUN update-ca-certificates

ADD ./custom.ini $PHP_INI_DIR/conf.d

RUN echo "* * * * * php -f /var/www/html/bitrix/modules/main/tools/cron_events.php >> /var/log/cron.log 2>&1" >> /etc/crontab
RUN chmod 0644 /etc/crontab
RUN crontab /etc/crontab
