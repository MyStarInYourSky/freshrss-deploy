ARG CONTAINER_BUILD_BASEIMAGE
ARG TARGET_PLATFORM
FROM --platform=$TARGET_PLATFORM $CONTAINER_BUILD_BASEIMAGE as build-extensions
LABEL org.opencontainers.image.source=https://github.com/MyStarInYourSky/freshrss-kubernetes
LABEL org.opencontainers.image.description="FreshRSS"
LABEL org.opencontainers.image.licenses=MIT
RUN apk add --no-cache bash
SHELL ["/bin/bash", "-c"]
RUN apk add --no-cache gmp gmp-dev icu icu-dev libzip-dev libzip libpq-dev \
    && if [[ "$TARGET_PLATFORM" == "linux/arm64/v8" ]]; then \
            docker-php-ext-configure gmp --build x86_64-pc-linux-musl --host aarch64-linux-musl; \
            docker-php-ext-configure intl --build x86_64-pc-linux-musl --host aarch64-linux-musl; \
            docker-php-ext-configure zip --build x86_64-pc-linux-musl --host aarch64-linux-musl; \
            docker-php-ext-configure pdo --build x86_64-pc-linux-musl --host aarch64-linux-musl; \
            docker-php-ext-configure pdo_mysql --build x86_64-pc-linux-musl --host aarch64-linux-musl; \
            docker-php-ext-configure pdo_pgsql --build x86_64-pc-linux-musl --host aarch64-linux-musl; \
	    docker-php-ext-install -j"$(nproc)" gmp intl zip pdo pdo_mysql pdo_pgsql; \
	    docker-php-ext-enable gmp intl zip pdo pdo_mysql pdo_pgsql; \
	elif [[ "$TARGET_PLATFORM" == "arm/v7" ]]; then \
            docker-php-ext-configure gmp --build x86_64-pc-linux-musl --host arm-linux-musleabihf; \
            docker-php-ext-configure intl --build x86_64-pc-linux-musl --host arm-linux-musleabihf; \
            docker-php-ext-configure zip --build x86_64-pc-linux-musl --host arm-linux-musleabihf; \
            docker-php-ext-configure pdo --build x86_64-pc-linux-musl --host arm-linux-musleabihf; \
            docker-php-ext-configure pdo_mysql --build x86_64-pc-linux-musl --host arm-linux-musleabihf; \
            docker-php-ext-configure pdo_pgsql --build x86_64-pc-linux-musl --host arm-linux-musleabihf; \
	    docker-php-ext-install -j"$(nproc)" gmp intl zip pdo pdo_mysql pdo_pgsql; \
	    docker-php-ext-enable gmp intl zip pdo pdo_mysql pdo_pgsql; \
	elif [[ "$TARGET_PLATFORM" == "linux/arm/v6" ]]; then \
            docker-php-ext-configure gmp --build x86_64-pc-linux-musl --host arm-linux-musleabi; \
            docker-php-ext-configure intl --build x86_64-pc-linux-musl --host arm-linux-musleabi; \
            docker-php-ext-configure zip --build x86_64-pc-linux-musl --host arm-linux-musleabi; \
            docker-php-ext-configure pdo --build x86_64-pc-linux-musl --host arm-linux-musleabi; \
            docker-php-ext-configure pdo_mysql --build x86_64-pc-linux-musl --host arm-linux-musleabi; \
            docker-php-ext-configure pdo_pgsql --build x86_64-pc-linux-musl --host arm-linux-musleabi; \
	    docker-php-ext-install -j"$(nproc)" gmp intl zip pdo pdo_mysql pdo_pgsql; \
	    docker-php-ext-enable gmp intl zip pdo pdo_mysql pdo_pgsql; \
        elif [[ "$TARGET_PLATFORM" == "linux/386" ]]; then \
            docker-php-ext-configure gmp --build x86_64-pc-linux-musl --host i386-pc-linux-musl; \
            docker-php-ext-configure intl --build x86_64-pc-linux-musl --host i386-pc-linux-musl; \
            docker-php-ext-configure zip --build x86_64-pc-linux-musl --host i386-pc-linux-musl; \
            docker-php-ext-configure pdo --build x86_64-pc-linux-musl --host i386-pc-linux-musl; \
            docker-php-ext-configure pdo_mysql --build x86_64-pc-linux-musl --host i386-pc-linux-musl; \
            docker-php-ext-configure pdo_pgsql --build x86_64-pc-linux-musl --host i386-pc-linux-musl; \
	    docker-php-ext-install -j"$(nproc)" gmp intl zip pdo pdo_mysql pdo_pgsql; \
	    docker-php-ext-enable gmp intl zip pdo pdo_mysql pdo_pgsql; \
	elif [[ "$TARGET_PLATFORM" == "linux/amd64" ]]; then \
            docker-php-ext-configure gmp --build x86_64-pc-linux-musl --host x86_64-pc-linux-musl; \
            docker-php-ext-configure intl --build x86_64-pc-linux-musl --host x86_64-pc-linux-musl; \
            docker-php-ext-configure zip --build x86_64-pc-linux-musl --host x86_64-pc-linux-musl; \
            docker-php-ext-configure pdo --build x86_64-pc-linux-musl --host x86_64-pc-linux-musl; \
            docker-php-ext-configure pdo_mysql --build x86_64-pc-linux-musl --host x86_64-pc-linux-musl; \
            docker-php-ext-configure pdo_pgsql --build x86_64-pc-linux-musl --host x86_64-pc-linux-musl; \
	    docker-php-ext-install -j"$(nproc)" gmp intl zip pdo pdo_mysql pdo_pgsql; \
	    docker-php-ext-enable gmp intl zip pdo pdo_mysql pdo_pgsql; \
        fi \
    && apk add --no-cache gmp icu libzip libpq

FROM --platform=$TARGET_PLATFORM $CONTAINER_BUILD_BASEIMAGE as build-pecl
LABEL org.opencontainers.image.source=https://github.com/MyStarInYourSky/freshrss-kubernetes
LABEL org.opencontainers.image.description="FreshRSS"
LABEL org.opencontainers.image.licenses=MIT
RUN apk add --update --no-cache --virtual .build-dependencies $PHPIZE_DEPS \ 
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && pecl clear-cache \
    && apk del .build-dependencies 

FROM --platform=$TARGET_PLATFORM $CONTAINER_BUILD_BASEIMAGE
LABEL org.opencontainers.image.source=https://github.com/MyStarInYourSky/freshrss-kubernetes
LABEL org.opencontainers.image.description="FreshRSS"
LABEL org.opencontainers.image.licenses=MIT
ARG PHP_API_VERSION
ARG APP_VER
RUN apk add --no-cache bash
SHELL ["/bin/bash", "-c"]
COPY --from=build-pecl /usr/local/lib/php/extensions/no-debug-non-zts-${PHP_API_VERSION}/ /tmp/pecl_zts_extensions
COPY --from=build-pecl /usr/local/include/php/ext/ /tmp/pecl_include_extensions
COPY --from=build-pecl /usr/local/etc/php/conf.d/ /tmp/pecl_conf
COPY --from=build-extensions /usr/local/lib/php/extensions/no-debug-non-zts-${PHP_API_VERSION}/ /tmp/php_zts_extensions
COPY --from=build-extensions /usr/local/include/php/ext/ /tmp/php_include_extensions
COPY --from=build-extensions /usr/local/etc/php/conf.d/ /tmp/php_conf
RUN cp -R /tmp/pecl_zts_extensions/* /tmp/php_zts_extensions/* /usr/local/lib/php/extensions/no-debug-non-zts-${PHP_API_VERSION}/ \
    && cp -R /tmp/pecl_include_extensions/* /tmp/php_include_extensions/* /usr/local/include/php/ext \
    && cp -R /tmp/pecl_conf/* /tmp/php_conf/* /usr/local/etc/php/conf.d
RUN apk add --no-cache wget unzip gmp icu libzip libpq \
    && wget --progress=dot:giga https://github.com/FreshRSS/FreshRSS/archive/refs/tags/${APP_VER}.zip \
    && unzip -oq ${APP_VER}.zip \
    && mv FreshRSS-${APP_VER}/ /app \
    && apk del wget unzip \
    && mkdir -p /app/data /nginx
RUN adduser -h /app -s /bin/bash -u 1000 -g 1000 -D app \
    && sed -i 's/^user \=.*/user = app/' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's/^group \=.*/group = app/' /usr/local/etc/php-fpm.d/www.conf \
    && chown -R app:app /app /nginx
WORKDIR /app
USER app
EXPOSE 9000
CMD ["php-fpm"]
