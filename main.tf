# TODO: Designate a cloud provider, region, and credentials
# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
# TODO: provision 2 m4.large EC2 instances named Udacity M4

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
  alias   = "primary"
  profile = "default"
  region  = var.primary-region
}

provider "aws" {
  alias   = "secondary"
  profile = "default"
  region  = var.secondary-region
}

## Primary VPC definitions

## Primary VPC
resource "aws_vpc" "primary-vpc" {
  provider         = aws.primary
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "primary-vpc"
  }
}




# Secondary VPC definitions
resource "aws_vpc" "secondary-vpc" {
  provider         = aws.secondary
  cidr_block       = "172.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "secondary-vpc"
  }
}





resource "aws_s3_bucket" "primary-s3-bucket" {
  provider = aws.primary
  bucket   = "saa-primary-s3-cloud-storage"
  acl      = "private"

  tags = {
    Name = "saa-primary-s3-cloud-storage"
    env  = "dev-udc"
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "secondary-s3-bucket" {
  provider = aws.secondary
  bucket   = "saa-secondary-s3-cloud-storage"
  acl      = "private"

  tags = {
    Name = "saa-secondary-s3-cloud-storage"
    env  = "dev-udc"
  }

  versioning {
    enabled = true
  }
}
