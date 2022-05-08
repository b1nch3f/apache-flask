############################################################
# Dockerfile to build Flask App
# Based on
############################################################

# Set the base image
FROM python:3.7.9-slim

# File Author / Maintainer
MAINTAINER Sangram Kesari Ray

RUN apt-get update && apt-get install -y apache2 \
    apache2-utils \
    apache2-dev \
    libapache2-mod-wsgi-py3 \
    vim \
 && apt-get clean \
 && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/*

# Copy over and install the requirements
COPY ./requirements.txt /var/www/apache-flask/requirements.txt
RUN pip install -r /var/www/apache-flask/requirements.txt

# Copy over the apache configuration file and enable the site
COPY ./apache-flask.conf /etc/apache2/sites-available/apache-flask.conf
RUN a2ensite apache-flask
RUN a2enmod headers

# Copy over the wsgi file
COPY ./apache-flask.wsgi /var/www/apache-flask/apache-flask.wsgi

COPY ./main.py /var/www/apache-flask/

RUN a2dissite 000-default.conf
RUN a2ensite apache-flask.conf

# LINK apache config to docker logs.
RUN ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
    ln -sf /proc/self/fd/1 /var/log/apache2/error.log


EXPOSE 80

WORKDIR /var/www/apache-flask

CMD  /usr/sbin/apache2ctl -D FOREGROUND
