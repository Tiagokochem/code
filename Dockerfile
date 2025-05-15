FROM composer:2.7 as laravel_installer
WORKDIR /app
RUN composer create-project laravel/laravel:^11.0 . --no-interaction

# Agora o PHP com MongoDB
FROM php:8.3-fpm

# Dependências
RUN apt-get update && apt-get install -y \
    git curl unzip zip libpng-dev libjpeg-dev libfreetype6-dev libonig-dev libxml2-dev libzip-dev libssl-dev pkg-config \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql zip mbstring exif pcntl bcmath gd

# MongoDB driver
RUN pecl install mongodb && docker-php-ext-enable mongodb

# Instala Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Cria diretório da app
WORKDIR /var/www

# Copia o Laravel pronto
COPY --from=laravel_installer /app /var/www

# Permissões
RUN chown -R www-data:www-data /var/www && chmod -R 775 /var/www/storage /var/www/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
