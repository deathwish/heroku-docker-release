#!/bin/bash

set -e

APP_NAME=heroku-release-repro
HEROKU_APP_NAME=${HEROKU_APP_NAME:-heroku-release-repro-actual}
HEROKU_API_KEY=$(heroku auth:token)

docker build -t ${APP_NAME} .
docker tag ${APP_NAME}:latest registry.heroku.com/${HEROKU_APP_NAME}:latest
docker push registry.heroku.com/${HEROKU_APP_NAME}:latest

DOCKER_IMAGE_ID=$(docker inspect registry.heroku.com/${HEROKU_APP_NAME}:latest --format={{.Id}})

curl --fail \
     -X PATCH https://api.heroku.com/apps/${HEROKU_APP_NAME}/formation \
     -H "Content-Type: application/json" \
     -H "Accept: application/vnd.heroku+json; version=3.docker-releases" \
     -H "Authorization: Bearer ${HEROKU_API_KEY}" \
     --data-binary @- <<-EOF
     {
       "updates": [
         { "type": "release", "docker_image": "${DOCKER_IMAGE_ID}", "command": "/usr/local/bin/do-release-tasks.sh" },
         { "type": "web", "docker_image": "${DOCKER_IMAGE_ID}" }
       ]
     }
EOF
