# HelloWorldLambda

Demo project with AWS Lambda in Swift

## Download the code locally
```
git clone https://github.com/Andrea-Scuderi/HelloWorlLambda.git
cd HelloWorldLambda
```

## Build & Package the Lambda

```
./scripts/build-and-package.sh HelloWorldLambda
```

## Deploy the Lambda with Serverless framework

```
./scripts/serverless-deploy.sh HelloWorldLambda
```


## Remove the Lambda deployment

```
./scripts/serverless-remove.sh HelloWorldLambda
```