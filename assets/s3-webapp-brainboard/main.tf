# Brainboard auto-generated file.

resource "aws_s3_bucket" "bucket" {
  force_destroy = true
  bucket        = "${var.prefix}-${var.name}"

  tags = {
    env      = "Development"
  }
}

resource "aws_s3_bucket_website_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  error_document {
    key = "error.html"
  }

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "policy" {
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"
            ]
        }
    ]
}
EOF
  bucket = aws_s3_bucket.bucket.id
}

resource "aws_s3_bucket_object" "webapp" {
  key          = "index.html"
  content_type = "text/html"
  content      = file("${path.module}/assets/index.html")
  bucket       = aws_s3_bucket.bucket.id
  acl          = "public-read"

  tags = {
    env      = "Development"
  }
}