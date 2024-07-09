#!/usr/bin/env bash
set -euo pipefail

mkdir -p /state/runner/data

cp ./config.yaml /state/runner/config.yaml

RUNNER_TOKEN=$(curl -s -X 'GET' 'http://5min-idp-control-plane:30080/api/v1/admin/runners/registration-token' -H 'accept: application/json' -H 'authorization: Basic NW1pbmFkbWluOjVtaW5hZG1pbg==' | jq -r .token)

docker volume create gitea_runner_data
docker create \
    --name gitea_runner \
    -v gitea_runner_data:/data \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e CONFIG_FILE=/config.yaml \
    -e GITEA_INSTANCE_URL=http://5min-idp-control-plane:30080 \
    -e GITEA_RUNNER_REGISTRATION_TOKEN=$RUNNER_TOKEN \
    -e GITEA_RUNNER_NAME=local \
    -e GITEA_RUNNER_LABELS=local \
    --network kind \
    gitea/act_runner:latest
docker cp /state/runner/config.yaml gitea_runner:/config.yaml
docker start gitea_runner
