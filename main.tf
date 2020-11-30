## Terraform provider definitions
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# AWS provider with alias definitions for primary and secondary regions
provider "aws" {
  alias  = "primary"
  region = var.primary.region
}

provider "aws" {
  alias  = "secondary"
  region = var.secondary.region
}

## Primary VPC definitions

## Primary VPC
resource "aws_vpc" "primary-vpc" {
  provider             = aws.primary
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    var.udc_default_tags,
    {
      Name = "primary-vpc"
    }
  )
}

# Secondary VPC definitions
resource "aws_vpc" "secondary-vpc" {
  provider             = aws.secondary
  cidr_block           = "172.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    var.udc_default_tags,
    {
      Name = "secondary-vpc"
    }
  )
}

# To start up S3 buckets please change the bucket name in the variable file for primary and secondary
# resource "aws_s3_bucket" "primary-s3-bucket" {
#   provider = aws.primary
#   bucket   = var.primary.s3-bucket-01
#   acl      = "private"

#   tags = merge(
#     var.udc_default_tags,
#     {
#       Name = var.primary.s3-bucket-01

#     }
#   )

#   versioning {
#     enabled = true
#   }
# }

# resource "aws_s3_bucket" "secondary-s3-bucket" {
#   provider = aws.secondary
#   bucket   = var.secondary.s3-bucket-01
#   acl      = "private"

#   tags = merge(
#     var.udc_default_tags,
#     {
#       Name = "saa-secondary-s3-cloud-storage-202011-acg2"

#     }
#   )

#   versioning {
#     enabled = true
#   }
# }
