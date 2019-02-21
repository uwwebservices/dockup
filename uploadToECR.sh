#!/bin/bash

#### VARS ####

NAME=dockup
TAG=latest
REGION=us-east-1
ECR_URL=497422317586.dkr.ecr.us-east-1.amazonaws.com

##############

echo "Getting AWS Credentials for $REGION"
$(aws ecr get-login --no-include-email --region $REGION)
echo "Building the $NAME docker image"
docker build -t $NAME .
echo "Tagging image as $NAME:$TAG"
docker tag $NAME:$TAG $ECR_URL/$NAME:$TAG
echo "Uploading to ECR"
docker push $ECR_URL/$NAME:$TAG