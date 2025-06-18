FROM nginx:1.28.0-alpine
COPY build/web /usr/share/nginx/html

EXPOSE 80