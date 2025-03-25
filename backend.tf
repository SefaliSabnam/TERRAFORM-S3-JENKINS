terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket-rony2025"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
  }
}
