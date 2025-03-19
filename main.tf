# Create S3 Bucket
resource "aws_s3_bucket" "portfolio" {
  bucket = var.bucket_name
}

# Configure S3 bucket for website hosting
resource "aws_s3_bucket_website_configuration" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Set bucket ownership to BucketOwnerPreferred
resource "aws_s3_bucket_ownership_controls" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Set public access block (optional)
resource "aws_s3_bucket_public_access_block" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Add bucket policy for public read access
resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.portfolio.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.portfolio.arn}/*"
      }
    ]
  })
}

# Upload index.html to S3 bucket
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.portfolio.id
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"
}

# Output the S3 website URL
output "s3_website_url" {
  value = aws_s3_bucket_website_configuration.portfolio.website_endpoint
}
