# TODO: Designate a cloud provider, region, and credentials
# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
# TODO: provision 2 m4.large EC2 instances named Udacity M4

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_vpc" "primary-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "primary-vpc"
  }
}

resource "aws_vpc" "secondary-vpc" {
  cidr_block       = "172.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "secondary-vpc"
  }
}