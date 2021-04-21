# Lambda Hook to test Blue-Green Deployment

This repo contains the lambda hook that tests this [blue-green deployment](https://github.com/SekibOmazic/blue-green-fargate).

It is also used [here](https://github.com/SekibOmazic/deploy-on-fargate)

## Pre-requisites

You need an S3 bucket which will store the lambda function code.
This lambda assumes you have a service running on

```
https://<API_NAME>.<HOSTED_ZONE_NAME>
```

For example: https://api.my-domain.com

## Deploy

1. Update variables in [deploy.sh](deploy.sh)

2. From your terminal run:

```
./deploy.sh
```

## Cleanup

In AWS Console go to CloudFormation and manually delete stack "blue-green-deployment-hook"
