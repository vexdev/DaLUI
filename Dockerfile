FROM nginx:1.28.0-alpine
COPY build/web /usr/share/nginx/html

COPY dalui.conf.template /etc/nginx/templates/default.conf.template

EXPOSE 80