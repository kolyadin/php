FROM php:7.2-alpine

MAINTAINER aleksey.kolyadin@isobar.ru

RUN apk add --no-cache --virtual .build-deps autoconf g++ make
RUN apk add --no-cache imagemagick-dev libtool bzip2-dev icu-dev gettext-dev libpng-dev libjpeg-turbo libjpeg-turbo-dev libmcrypt-dev postgresql-dev libxml2-dev

RUN docker-php-ext-configure gd --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install bcmath \
        bz2 \
        exif \
        gettext \
        gd \
        intl \
        opcache \
        pcntl \
        pdo_mysql \
        pdo_pgsql \
        pgsql \
        soap \
        sockets \
        zip

RUN pecl install Imagick && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini
RUN pecl install xdebug && echo "zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini
RUN pecl install mcrypt-1.0.1 && echo "extension=mcrypt.so" > /usr/local/etc/php/conf.d/mcrypt.ini

RUN apk del .build-deps

RUN cd /usr/local/lib \
	&& wget https://composer.github.io/installer.sig -O - -q | tr -d '\n' > installer.sig \
	&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php -r "if (hash_file('SHA384', 'composer-setup.php') === file_get_contents('installer.sig')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
	&& php composer-setup.php \
	&& php -r "unlink('composer-setup.php'); unlink('installer.sig');" \
	&& mv /usr/local/lib/composer.phar /usr/local/bin/composer

RUN chown root:www-data /usr/local/etc/php/conf.d/ \
    && chmod -R g+w /usr/local/etc/php/conf.d/ \
    && mkdir /var/www \
    && chown www-data:www-data /var/www

USER www-data
WORKDIR /var/www