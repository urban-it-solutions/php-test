FROM php:7.1-apache

MAINTAINER Ben Jannedy (ben@jannedy.de)

 

# Install GD

RUN apt-get update \

    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \

    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \

    && docker-php-ext-install gd

 

# Install MCrypt

RUN apt-get update \

    && apt-get install -y libmcrypt-dev \

    && docker-php-ext-install mcrypt

 

# Install Intl

RUN apt-get update \

    && apt-get install -y libicu-dev \

    && docker-php-ext-install intl

 

# Install curl

RUN apt-get update \

    && apt-get install curl

 

# Install calendar extension

#RUN apt-get update && apt-get install -y php-calendar && docker-php-ext-install calendar

 

RUN docker-php-ext-install calendar

 

## ENV XDEBUG_ENABLE 0

##RUN pecl config-set preferred_state beta \

##    && pecl install -o -f xdebug \

##   && rm -rf /tmp/pear \

##    && pecl config-set preferred_state stable

## COPY ./99-xdebug.ini.disabled /usr/local/etc/php/conf.d/

 

# Install Imap

RUN apt-get update && apt-get install -y libc-client-dev libkrb5-dev && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \

    && docker-php-ext-install imap

 

# Install Mysql

RUN docker-php-ext-install mysqli pdo_mysql

 

# Install Composer

#RUN curl -sS https://getcomposer.org/installer | php \

#    && mv composer.phar /usr/local/bin/composer

 

# Install mbstring

RUN docker-php-ext-install mbstring

 

# Install soap

#RUN apt-get update \

#    && apt-get install -y libxml2-dev \

#    && docker-php-ext-install soap

 

# Install opcache

#RUN docker-php-ext-install opcache

 

# Install PHP zip extension

RUN docker-php-ext-install zip

 

# Install Git

RUN apt-get update \

    && apt-get install -y git

 

# Install xsl

RUN apt-get update \

    && apt-get install -y libxslt-dev \

    && docker-php-ext-install xsl

 

# Define PHP_TIMEZONE env variable

ENV PHP_TIMEZONE Europe/Berlin

 

# Configure Apache Document Root

ENV APACHE_DOC_ROOT /var/www/html

 

# Enable Apache mod_rewrite

RUN a2enmod rewrite

 

# Enable Apache mod_expires

RUN a2enmod expires

 

# Additional PHP ini configuration

COPY ./files/999-php.ini /usr/local/etc/php/conf.d/

 

COPY ./files/index.php /var/www/html/index.php

 

# Cron

#COPY ./files/crontab /etc/cron/crontab

 

#RUN chmod 0644 /etc/cron/crontab

 

#RUN touch /var/log/cron.log

 

#RUN apt-get -y install -qq --force-yes cron

 

#RUN crontab /etc/cron/crontab

 

# Special Apache config

COPY ./files/001-rescloud.conf /etc/apache2/sites-available/

RUN a2dissite 000-default.conf

RUN a2ensite 001-rescloud.conf

 

# Install ssmtp Mail Transfer Agent

RUN apt-get update \

    && apt-get install -y ssmtp \

    && apt-get clean \

    && echo "FromLineOverride=YES" >> /etc/ssmtp/ssmtp.conf \

    && echo 'sendmail_path = "/usr/sbin/ssmtp -t"' > /usr/local/etc/php/conf.d/mail.ini

 

# Install MySQL CLI Client

RUN apt-get update \

    && apt-get install -y mysql-client

 

########################################################################################################################

 

# Start!

#COPY ./start /usr/local/bin/

#CMD ["start"]

#CMD ["cron", "-f"]
COPY files/ports.conf /etc/apache2/
EXPOSE 8080

CMD ["apache2-foreground"]

 
