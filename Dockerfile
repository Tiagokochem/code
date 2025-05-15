# Etapa 1: instala Laravel direto no caminho final
FROM composer:2.7 as laravel_installer

WORKDIR /tmp/laravel
RUN composer create-project laravel/laravel:^11.0 . --no-interaction

# Etapa 2: imagem PHP com extensões
FROM php:8.3-fpm

# Instala dependências do sistema e extensões PHP necessárias
RUN apt-get update && apt-get install -y \
    git curl unzip zip libpng-dev libjpeg-dev libfreetype6-dev libonig-dev libxml2-dev libzip-dev libssl-dev pkg-config \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql zip mbstring exif pcntl bcmath gd

# Instala driver MongoDB
RUN pecl install mongodb && docker-php-ext-enable mongodb

# Copia o Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Define diretório de trabalho
WORKDIR /var/www

# Copia o Laravel gerado anteriormente
COPY --from=laravel_installer /tmp/laravel /var/www

# Ajusta permissões
RUN chown -R www-data:www-data /var/www && chmod -R 775 /var/www/storage /var/www/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
