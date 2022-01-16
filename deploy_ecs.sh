#!/usr/bin/env bash

# --file docker-compose.yml \
# --file docker-compose.override.yml \
# --project-name hello_ecs \
# docker compose build


aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 007818600463.dkr.ecr.us-east-1.amazonaws.com

docker-compose \
    -f docker-compose.base.yml \
    -f docker-compose.production.yml \
    -p hello_ecs \
    build

docker push 007818600463.dkr.ecr.us-east-1.amazonaws.com/helloecs_flask:latest
docker push 007818600463.dkr.ecr.us-east-1.amazonaws.com/helloecs_react:latest

docker \
    --context helloecs_personal \
    compose \
    -f docker-compose.base.yml \
    -f docker-compose.production.yml \
    -p helloecs2 \
    up