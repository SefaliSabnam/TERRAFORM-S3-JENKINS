
# Create S3 Bucket for website hosting
resource "aws_s3_bucket" "portfolio" {
  bucket = var.bucket_name
  acl    = "public-read"

  website {
    index_document = var.index_document
  }
}

# Set bucket policy to allow public read access
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

# Upload index.html to S3
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.portfolio.id
  key    = var.index_document
  source = "index.html"
  acl    = "public-read"
  content_type = "text/html"
}

# Upload CSS to S3
resource "aws_s3_object" "style" {
  bucket = aws_s3_bucket.portfolio.id
  key    = "style.css"
  source = "style.css"
  acl    = "public-read"
  content_type = "text/css"
}

# Create CloudFront distribution for the website
resource "aws_cloudfront_distribution" "portfolio" {
  origin {
    domain_name = "${aws_s3_bucket.portfolio.bucket_regional_domain_name}"
    origin_id   = "S3-${aws_s3_bucket.portfolio.id}"

    s3_origin_config {
      origin_access_identity = ""
    }
  }

  enabled             = true
  default_root_object = var.index_document

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.portfolio.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

# Output the S3 website URL
output "s3_website_url" {
  value = "http://${aws_s3_bucket.portfolio.website_endpoint}"
}

# Output the CloudFront distribution URL
output "cloudfront_url" {
  value = aws_cloudfront_distribution.portfolio.domain_name
}
