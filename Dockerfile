FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    git unzip libpng-dev libjpeg-dev libfreetype6-dev \
    libzip-dev libicu-dev libxml2-dev libpq-dev \
    && docker-php-ext-install mysqli pdo pdo_mysql pdo_pgsql pgsql intl zip gd

RUN a2enmod rewrite
RUN echo "max_input_vars=5000" > /usr/local/etc/php/conf.d/custom.ini
RUN echo "upload_max_filesize=100M" >> /usr/local/etc/php/conf.d/custom.ini
RUN echo "post_max_size=100M" >> /usr/local/etc/php/conf.d/custom.ini
RUN echo "memory_limit=512M" >> /usr/local/etc/php/conf.d/custom.ini

COPY . /var/www/html/

RUN mkdir -p /tmp/moodledata \
    && chown -R www-data:www-data /tmp/moodledata \
    && chmod -R 777 /tmp/moodledata

RUN chown -R www-data:www-data /var/www/html

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80
