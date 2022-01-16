# Hello ECS

This is a basic pretty bare-bones repo to demonstrate a simple app with nginx and flask, and deploying it locally for
local dev and also to AWS ECS.

## Setup

1. Create an IAM user with the [permissions necessary](https://docs.docker.com/cloud/ecs-integration/) to deploy to ECS
2. Set up an AWS profile locally for that IAM user
3. Locally, create a "docker context". `docker context create ecs <name>`. The name can be anything you want, just be
sure to update it to what you use in `deploy_ecs.sh` by `docker --context <context name>`
4. It will ask you to select an AWS profile. Select the one you just created
5. `./deploy_local.sh` and play around Make sure things work as intended.
6. Update `./deploy_ecs.sh` to point to the docker repository being used. At the moment this is building and pushing to my personal AWS account, so it will fail for you.
7. Update `docker-compose.production.yml` to point to the same images as the one in `./deploy_ecs.sh`
8. Run `./deploy_ecs.sh`
9. When it's done, run `docker --context <context name> ps`. See which endpoint the nginx container is listening on, and hit that in your browser
10. To inspect the cloudformation template that is generated from the docker-compose file, do:

```bash
docker \
    --context helloecs_personal \
    compose \
    -f docker-compose.base.yml \
    -f docker-compose.production.yml \
    -p helloecs \
    convert
```

* Notably, this cloudformation template is huge compared to the minimal docker-compose configuration we had to do. [These docs](https://docs.docker.com/cloud/ecs-integration/) show how to customize.

## Multiple versions

All you need to do to deploy multiple versions/stacks of the same app is change the `-p` argument to `docker compose ... up`. This way you can
have multiple environments (stage, demo, test etc...) that can function independently. It also makes it trivial to stand up and tear down developer or PR-specific environments.

## Zero down-time updates
https://docs.docker.com/cloud/ecs-integration/#rolling-update

## Destroying environments

It's as simple as `docker compose ... -p <name> down`. However, this destroys everything related to the cluster, including log groups. It would be nice to ensure that log groups stick around for prod environments etc...