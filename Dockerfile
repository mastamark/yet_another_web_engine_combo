# Yet Another Web Engine Combo - Apache2/http/https using legit ssl certs + php5.6 + mysqli extension
# SSL default served up from "/var/www/secure/"
# SSL ENVs should be provided at runtime with full valid paths, eg "/etc/ssl/sweet_certs/sweet_crt.crt"
# php.ini is default other then setting timezone to "UTC"

FROM php:5.6-apache
COPY default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
COPY php.ini /usr/local/etc/php/
RUN ln -s /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/ssl.conf \
  && ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ssl.load \
  && ln -s /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/socache_shmcb.load \
  && ln -s /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf \
  && /usr/local/bin/docker-php-ext-install mysql mysqli 
  
ENV APACHE_LOG_DIR /var/log/apache2
ENV SSL_CERT_PATH_AND_FILE provide_me_at_runtime
ENV SSL_KEY_PATH_AND_FILE provide_me_at_runtime

WORKDIR /var/www/html
EXPOSE 80
EXPOSE 443

CMD ["apache2-foreground"]
