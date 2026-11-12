FROM php:8.5-cli

ENV TERM='xterm-256color'
ENV TZ='Europe/Berlin'

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
    apt-utils mariadb-client iputils-ping locales sudo curl git hwinfo bat btop fzf lsd micro \
    zsh zsh-autosuggestions zsh-syntax-highlighting \
    libfreetype6-dev libicu-dev libmagickwand-dev libjpeg62-turbo-dev libpng-dev libwebp-dev libzip-dev libavif-dev \
  && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp --with-avif \
  && docker-php-ext-install -j$(nproc) exif gd intl mysqli pdo pdo_mysql zip \
  && pecl install imagick && docker-php-ext-enable imagick

RUN { \
    echo 'memory_limit = 8192M'; \
    echo 'date.timezone = Europe/Berlin'; \
  } > $PHP_INI_DIR/conf.d/zz-dev.ini

RUN bash -c "$(curl -sLo- https://superfile.dev/install.sh)"
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

ENV LANG='en_US.UTF-8'
ENV LANGUAGE='en_US:en'
ENV LC_ALL='en_US.UTF-8'

RUN rm -rf /var/www/html \
  && chsh -s /usr/bin/zsh www-data \
  && echo 'www-data ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/www-data \
  && chmod 0440 /etc/sudoers.d/www-data

COPY --chown=33:33 home /var/www

WORKDIR /var/www
USER www-data
