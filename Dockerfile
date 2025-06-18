FROM nginx:1.28.0-alpine
COPY build/web /usr/share/nginx/html

ENV NGINX_PORT=8699

EXPOSE 8699