variable "region" {

}

data "aws_partition" "current" {}

variable "environment" {

}

variable "project" {
  
}

variable "s3bucket" {
  
}

variable "app_version" {

}

variable "swift_build_path" {
    default = "../.build/lambda/"
}