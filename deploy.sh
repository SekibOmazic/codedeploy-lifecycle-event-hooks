#!/usr/bin/env bash

GREEN="\033[1;32m"

AWS_REGION=<YOUR_REGION>
LAMBDA_ARTIFACTS_BUCKET=<YOUR_BUCKET>

HOSTED_ZONE_NAME=<YOUR_HOSTED_ZONE_NAME> # e.g. my-domain.com
API_NAME=<YOUR_API_NAME> # e.g. api
DOMAIN_NAME=${API_NAME}.${HOSTED_ZONE_NAME} # e.g. api.my-domain.com

# use default AWS_REGION if not defined above
if [ -z ${AWS_REGION+x} ]; then 
  AWS_REGION=$(aws configure get region); 
fi

echo -e "${GREEN}Installing dependencies ...."
npm install

echo -e "${GREEN}Packaging cloudformation template ...."

aws cloudformation package \
  --template-file template.yaml \
  --output-template-file packaged-template.yaml \
  --s3-bucket ${LAMBDA_ARTIFACTS_BUCKET}

echo -e "${GREEN}Deploying lambda ...."

aws cloudformation deploy \
  --region ${AWS_REGION} \
  --template-file packaged-template.yaml \
  --stack-name blue-green-deployment-hook \
  --tags project=codedeploy-lifecycle-hook \
  --parameter-overrides DomainName=${DOMAIN_NAME} ApiName=${API_NAME} \
  --capabilities CAPABILITY_NAMED_IAM

echo -e "${GREEN}Deployment finished ...."
