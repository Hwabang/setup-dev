#!/bin/bash

# Pull latest container versions
docker-compose pull

# Build containers
docker-compose build

# Launch the containers
docker-compose up -d

# First run Certbot to get SSL certificates
docker-compose run --rm certbot certonly --webroot --webroot-path=/var/www/certbot -d hwabang.jeonghi.com --agree-tos --email jpakr0902@kookmin.ac.kr --no-eff-email

# Restart Nginx to use the new certificates
docker-compose restart nginx
