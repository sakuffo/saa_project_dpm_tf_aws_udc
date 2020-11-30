# To start up S3 buckets please change the bucket name in the variable file for primary and secondary
resource "aws_s3_bucket" "primary-s3-bucket" {
  provider = aws.primary
  bucket   = var.primary.s3-bucket-01
  acl      = "private"

  tags = merge(
    var.udc_default_tags,
    {
      Name = var.primary.s3-bucket-01

    }
  )

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "secondary-s3-bucket" {
  provider = aws.secondary
  bucket   = var.secondary.s3-bucket-01
  acl      = "private"

  tags = merge(
    var.udc_default_tags,
    {
      Name = var.secondary.s3-bucket-01

    }
  )

  versioning {
    enabled = true
  }
}