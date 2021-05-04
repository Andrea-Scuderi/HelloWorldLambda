terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.37"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.region
}


data "aws_caller_identity" "current" {}

locals {
  lambda_settings = {
    "helloWorldLamda"  = { 
      handler = "HelloWorldLambda",
      s3key = "HelloWorldLambda/lambda.zip"
    },
    "httpsLambda"  = {
      handler = "HTTPSLambda",
      s3key = "HTTPSLambda/lambda.zip"
    }
  }
}