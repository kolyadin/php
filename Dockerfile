FROM php:7.2
RUN apt-get update
RUN apt-get install -y libmagickwand-dev imagemagick \
	&& pecl install Imagick \
	&& echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini

RUN apt-get install -y libicu-dev && docker-php-ext-install intl

RUN docker-php-ext-install \
        bcmath \
        gettext \
        gd \
        pcntl \
        pdo_mysql \
        zip

ADD ./composer.sh /usr/local/lib/composer.sh
RUN apt-get install -y wget \
	&& cd /usr/local/lib \
	&& chmod +x ./composer.sh \
	&& ./composer.sh \
	&& mv /usr/local/lib/composer.phar /usr/local/bin/composer

RUN chmod g+w /usr/local/etc/php/conf.d/
RUN usermod -a -G staff www-data

USER www-data
