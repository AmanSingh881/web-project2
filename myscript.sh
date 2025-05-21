#! /bin/bash

AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="598361629012"
ECR_REPO_NAME="frontend"
CONTAINER_NAME="frontend_container"
HOST_PORT=80
CONTAINER_PORT=80
IMAGE_TAG="__VERSION__"

# Log in to ECR
aws ecr get-login-password --region ${AWS_REGION} \
  | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

# Pull the image
docker pull ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}

# Run the container (detached, restart on failure)
docker run -d \
  --name ${CONTAINER_NAME} \
  -p ${HOST_PORT}:${CONTAINER_PORT} \
  --restart unless-stopped \
  ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}
