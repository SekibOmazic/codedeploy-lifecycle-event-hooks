# Lambda Hook to test Blue-Green Deployment

This repo contains the lambda hook that tests this [blue-green deployment](https://github.com/SekibOmazic/blue-green-fargate)

## Manual Deployment

You need an S3 bucket which will store the lambda function code. Also make sure to obtain the domain name of your backend service. This would be something like `api.my-domain.com`.

```
npm install

aws cloudformation package \
  --template-file template.yaml \
  --output-template-file packaged-template.yaml \
  --s3-bucket <YOUR_BUCKET_FOR_ARTIFACTS>

aws cloudformation deploy \
  --region us-east-1 \
  --template-file packaged-template.yaml \
  --stack-name blue-green-deployment-hook \
  --tags project=blue-green-fargate \
  --parameter-overrides BackendDomain=<YOUR_DOMAIN> \
  --capabilities CAPABILITY_NAMED_IAM
```
