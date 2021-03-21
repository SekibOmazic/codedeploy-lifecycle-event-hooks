# Lambda Hook to test Blue-Green Deployment

This repo contains the lambda hook that tests this [blue-green deployment](https://github.com/SekibOmazic/blue-green-fargate)

## Deploy

TODO

```
aws cloudformation create-stack --stack-name blue-green-lambda-hook \
    --template-body file://cicd/pipeline.yaml \
    --parameters ParameterKey=SomeParam,ParameterValue=<SOME_VALUE> \
    --capabilities CAPABILITY_NAMED_IAM
```

## Manual Deploy

Since we don't use a registered domain (e.g. api.cool-service.com) we need to get the DNS of the ELB from the [blue-green-fargate](https://github.com/SekibOmazic/blue-green-fargate)

```
npm install

aws cloudformation package \
  --template-file cloudformation/infrastructure/cf-template.yaml \
  --output-template-file packaged-template.yaml \
  --s3-bucket <S3 bucket for storing the Lambda function code>

aws cloudformation deploy \
  --region us-east-1 \
  --template-file packaged-template.yaml \
  --stack-name blue-green-backend-hooks \
  --tags project=blue-green-fargate \
  --parameter-overrides BackendDomain=<YOUR_DOMAIN_OR_DNS_OF_THE_ELB> \
  --capabilities CAPABILITY_NAMED_IAM
```
