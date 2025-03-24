# Generate a random ID to make the bucket name unique
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Create the S3 bucket for the static website with a unique name
resource "aws_s3_bucket" "static_website" {
  bucket        = "my-static-website-rony2025-${random_id.bucket_suffix.hex}"  # Ensure the bucket name is globally unique
  force_destroy = true  # Allow deletion even if the bucket contains objects
}

# Configure the S3 bucket as a static website
resource "aws_s3_bucket_website_configuration" "static_site" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"  # Optional, you can add an error page
  }
}

# Allow public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Upload the index.html file to the S3 bucket (without ACLs)
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "index.html"
  source       = "index.html"  # Ensure this file exists locally
  content_type = "text/html"
  # Removed acl setting to avoid ACL conflicts
}

# Optionally, you can upload an error.html file (without ACLs)
resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "error.html"
  source       = "error.html"  # Ensure this file exists locally
  content_type = "text/html"
  # Removed acl setting to avoid ACL conflicts
}
