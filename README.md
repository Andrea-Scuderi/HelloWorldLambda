# HelloWorldLambda

[![Swift 5.3](https://img.shields.io/badge/Swift-5.3-blue.svg)](https://swift.org/download/) [![docker amazonlinux2](https://img.shields.io/badge/docker-amazonlinux2-orange.svg)](https://swift.org/download/)

Demo project with AWS Lambda in Swift

## Requirements

- Install [Docker](https://docs.docker.com/install/)
- Install [Serverless Framework](https://www.serverless.com/framework/docs/getting-started/)
- Ensure your AWS Account has the right [credentials](https://www.serverless.com/framework/docs/providers/aws/guide/credentials/) to deploy a Serverless stack.

## Download the code locally
```
git clone https://github.com/Andrea-Scuderi/HelloWorlLambda.git
cd HelloWorldLambda
```

## Examples

`HelloWorldLambda` : It shows how to code a basic lambda

`HTTPSLambda` : A Lambda which perform a network request using AsyncHTTPClient and Swift NIO

### Build & Package the Lambda

```
./scripts/build-and-package.sh HelloWorldLambda
```

### Deploy the Lambda with Serverless framework

```
./scripts/serverless-deploy.sh HelloWorldLambda
```

### Remove the Lambda deployment

```
./scripts/serverless-remove.sh HelloWorldLambda
```