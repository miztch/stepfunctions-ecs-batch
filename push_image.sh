#!/bin/bash

# set your ACCOUNT_ID and REGION
ACCOUNT_ID=
REGION=
IMAGE_NAME=sfn-ecs-sample-batch
ECR_REPO_URL=${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/sfn-ecs-sample-batch

aws ecr get-login-password --region ${REGION} \
| docker login \
  --username AWS \
  --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com

docker build -t ${IMAGE_NAME} terraform/ecs/

docker tag ${IMAGE_NAME}:latest ${ECR_REPO_URL}
docker push ${ECR_REPO_URL}
