FROM debian:bullseye

RUN apt-get update \
    && apt-get install -y nginx \
    && apt-get clean \
    && echo "daemon off;" >> /etc/nginx/nginx.conf

ADD ./docker/nginx/dev/default.conf /etc/nginx/sites-available/default

WORKDIR /var/www/symfony

EXPOSE 80

CMD ["nginx"]
