FROM nginx:1.19.3

# Remove the default configuration
RUN rm /etc/nginx/conf.d/default.conf

# Add our virtual host config for flask
ADD conf.d/ /etc/nginx/conf.d

# Copy over static assets
RUN mkdir -p /www/static
COPY ./static /www/static

ENV NGINX_PROXY_URL=helloecs_flask

# copy over post_build script
# This re-writes 127.0.0.1 to helloecs_flask
WORKDIR /root
COPY ./post_build.sh /root/
