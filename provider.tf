terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = var.state_bucket
    key    = var.state_key
    region = var.aws_region
  }
}

provider "aws" {
  region = var.aws_region
}
