docker-compose \
    -f docker-compose.yml \
    -f docker-compose.local.yml \
    -p hello_ecs \
    build

docker-compose \
    -f docker-compose.yml \
    -f docker-compose.local.yml \
    -p hello_ecs \
    up -d