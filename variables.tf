variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "S3 bucket name for website hosting"
  type        = string
  default     = "sefali-portfolio-site"
}

variable "index_document" {
  description = "Index document for S3 website"
  type        = string
  default     = "index.html"
}