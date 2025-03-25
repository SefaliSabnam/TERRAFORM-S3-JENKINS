terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"  # Use a stable version
    }
  }
}

provider "aws" {
  region = var.aws_region
}