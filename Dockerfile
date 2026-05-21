FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    git unzip libpng-dev libjpeg-dev libfreetype6-dev \
    libzip-dev libicu-dev libxml2-dev libpq-dev \
    && docker-php-ext-install mysqli pdo pdo_mysql pdo_pgsql pgsql intl zip gd

RUN a2enmod rewrite

COPY . /var/www/html/

RUN mkdir -p /tmp/moodledata \
    && chown -R www-data:www-data /tmp/moodledata \
    && chmod -R 777 /tmp/moodledata

RUN chown -R www-data:www-data /var/www/html

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80
