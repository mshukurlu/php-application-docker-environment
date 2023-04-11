FROM php:8.1-fpm
# INSTALL ZIP TO USE COMPOSER
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    unzip \
    git

RUN docker-php-ext-install zip
RUN docker-php-ext-install mysqli pdo pdo_mysql

# INSTALL AND UPDATE COMPOSER
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer self-update
WORKDIR /var/www/html/site
COPY . .

EXPOSE 9000
# INSTALL YOUR DEPENDENCIES
#RUN composer install
CMD bash -c "composer install && php-fpm -F"

#CMD ["php-fpm", "-F"]
