FROM python:3.6@sha256:52f872eae9755743c9494e0e3cf02a47d34b42032cab1e5ab777b30c3665d5f1

ENV FLASK_URL=helloecs_flask
ENV FLASK_PORT=6701
ENV FLASK_ENV=development

# nginx proxy settings
ENV NGINX_PROXY_URL=helloecs_flask

# pip install before switching to the workdir -- supports volume mapping for dev
COPY requirements.txt /usr/src/app/requirements.txt
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

# copy over the app
WORKDIR /usr/src/app
COPY . /usr/src/app/


