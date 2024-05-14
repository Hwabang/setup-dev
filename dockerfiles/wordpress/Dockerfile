# Use the official WordPress image from the Docker Hub
FROM wordpress:latest

# Install SSL certificates
COPY --from=certbot/certbot /etc/letsencrypt /etc/letsencrypt
