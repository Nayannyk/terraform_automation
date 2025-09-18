FROM nginx:alpine

WORKDIR /usr/share/nginx/html
COPY ./index.html ./index.html

# Replace placeholder with the container hostname each time the container starts
CMD sh -c "sed -i \"s/%%CONTAINER_ID%%/$(hostname)/g\" /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"
