variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "S3 bucket name for hosting the website"
  type        = string
  default     = "sefali-terraform-bucket"
}

variable "state_bucket" {
  description = "S3 bucket name for storing Terraform state"
  type        = string
  default     = "sefali-terraform-state"
}

variable "state_key" {
  description = "Path for storing the Terraform state file"
  type        = string
  default     = "terraform.tfstate"
}
