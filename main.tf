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

# Primary Subnet AZ1
resource "aws_subnet" "primary-subnet-01" {
  provider         = aws.primary
  vpc_id            = aws_vpc.primary-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.primary-public-subnet-01

  tags = {
    Name = "Primary Subnet 01"
  }
}

resource "aws_subnet" "primary-subnet-02" {
  provider         = aws.primary
  vpc_id            = aws_vpc.primary-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.primary-public-subnet-02

  tags = {
    Name = "Primary Subnet 02"
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