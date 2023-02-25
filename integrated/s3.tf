
resource "aws_s3_bucket" "log" {
    bucket = "soldesk-s3-test-13445"
    
    lifecycle {
      prevent_destroy = false
    }
    tags = {
        Name = "soldesk-s3-log-test"
    }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
    bucket = aws_s3_bucket.log.id
    rule {
        id = "log-rule"

        filter {
            prefix = "logs/"
        }
        status = "Enabled"
        transition {
            days = 30
            storage_class = "STANDARD_IA"
        }
    }
    
}


resource "aws_s3_bucket_acl" "acl" {
    bucket = aws_s3_bucket.log.id
    acl = "private"
}


resource "aws_s3_bucket_versioning" "versioning_s3" {
  bucket = aws_s3_bucket.log.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_policy" "allowa_access" {
  bucket = aws_s3_bucket.log.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::582318560864:root"
            },
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.log.arn}/*"
        }
    ]
})  
}