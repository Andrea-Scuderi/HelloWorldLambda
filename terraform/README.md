# Deploying AWS Lambda in Swift with Terraform

## Requirements

- Install [Docker](https://docs.docker.com/install/)
- Ensure your AWS Account has the right to deploy a Serverless stack.

## Install Terraform

Here the references for installing terraform:

`https://learn.hashicorp.com/tutorials/terraform/install-cli`


## Build & Package the Lambda

```
./scripts/build-and-package.sh HelloWorldLambda
./scripts/build-and-package.sh HTTPSLambda
```

## Update configuration with the s3buket variable

The s3 bucket is globally unique so you need to input the name you want o give to it.
You can add the key `s3bucket` to the file `terraform.tfvars`

Example:

>`s3bucket = "some-s3bucked-fancy-name-you-like"`

## Terraform Init

change directory to the folder containing the terraform files (`*.tf`)

>`cd terraform`

Init Terraform

>`terraform init`

## Terraform Plan

Check the plan of deployment is correct

> `terraform plan`

## Terraform Apply

Apply Terraform deployment and answer yes, if everything is correct

> `terraform apply`

## Test your Lambdas

Go to the AWS console and test your Lambdas.

## Terraform Destroy

Destroy Terraform deployment and answer yes, if everything is correct

> `terraform destroy`
