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

# Primary Route table
resource "aws_route_table" "primary-vpc-rt" {
  provider         = aws.primary
  vpc_id = aws_vpc.primary-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary-vpc-igw.id
  }

  tags = {
    Name = "Primary VPC RT"
  }
}

# Primary route table association. This will createthe rt applied to all subnets built in VPC
resource "aws_main_route_table_association" "primary-vpc-rt-assoc" {
  provider         = aws.primary
  vpc_id = aws_vpc.primary-vpc.id
  route_table_id = aws_route_table.primary-vpc-rt.id
}

#Primary Internet Gateway
resource "aws_internet_gateway" "primary-vpc-igw" {
  provider = aws.primary
  vpc_id   = aws_vpc.primary-vpc.id
  tags = {
    Name = "primary-vpc-igw"
  }
}



# Primary Subnet AZ1
resource "aws_subnet" "primary-subnet-01" {
  provider          = aws.primary
  vpc_id            = aws_vpc.primary-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.primary-public-subnet-01

  tags = {
    Name = "Primary Subnet 01"
  }
}

# Primary Subnet AZ2
resource "aws_subnet" "primary-subnet-02" {
  provider          = aws.primary
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

# Secondary Route table
resource "aws_route_table" "secondary-vpc-rt" {
  provider         = aws.secondary
  vpc_id = aws_vpc.secondary-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.secondary-vpc-igw.id
  }

  tags = {
    Name = "Secondary VPC RT"
  }
}

# Secondary route table association. This will createthe rt applied to all subnets built in VPC
resource "aws_main_route_table_association" "secondary-vpc-rt-assoc" {
  provider         = aws.secondary
  vpc_id = aws_vpc.secondary-vpc.id
  route_table_id = aws_route_table.secondary-vpc-rt.id
}

#Secondary Internet Gateway
resource "aws_internet_gateway" "secondary-vpc-igw" {
  provider = aws.secondary
  vpc_id   = aws_vpc.secondary-vpc.id
  tags = {
    Name = "secondary-vpc-igw"
  }
}

# Secondary Subnet AZ1
resource "aws_subnet" "secondary-subnet-01" {
  provider          = aws.secondary
  vpc_id            = aws_vpc.secondary-vpc.id
  cidr_block        = "172.0.1.0/24"
  availability_zone = var.secondary-public-subnet-01

  tags = {
    Name = "Secondary Subnet 01"
  }
}

# Secondary Subnet AZ2
resource "aws_subnet" "secondary-subnet-02" {
  provider          = aws.secondary
  vpc_id            = aws_vpc.secondary-vpc.id
  cidr_block        = "172.0.2.0/24"
  availability_zone = var.secondary-public-subnet-02

  tags = {
    Name = "Secondary Subnet 02"
  }
}

## EC2 Instance creation
data "aws_ssm_parameter" "amz2-ami-primary" {
  provider = aws.primary
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

data "aws_ssm_parameter" "amz2-ami-secondary" {
  provider = aws.secondary
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_key_pair" "primary-key" {
  provider = aws.primary
  key_name = "udc_rsa"
  public_key = file("~/.ssh/udc_rsa.pub")
}

resource "aws_key_pair" "secondary-key" {
  provider = aws.secondary
  key_name = "udc_rsa"
  public_key = file("~/.ssh/udc_rsa.pub")
}


resource "aws_instance" "web-server-paz-a" {
  provider = aws.primary
  count = 2
  ami = data.aws_ssm_parameter.amz2-ami-primary.value
  instance_type = "t2.micro"
  key_name = aws_key_pair.primary-key.key_name
  associate_public_ip_address = true
  subnet_id = aws_subnet.primary-subnet-01.id
  tags = {
    Name = join("-", ["web-server", count.index + 1, "a"])
  }
}

resource "aws_instance" "web-server-paz-b" {
  provider = aws.primary
  count = 2
  ami = data.aws_ssm_parameter.amz2-ami-primary.value
  instance_type = "t2.micro"
  key_name = aws_key_pair.primary-key.key_name
  associate_public_ip_address = true
  subnet_id = aws_subnet.primary-subnet-02.id
  tags = {
    Name = join("-", ["web-server", count.index + 1, "b"])
  }
}

resource "aws_instance" "db-paz-a" {
  provider = aws.primary
  count = 0
  ami = data.aws_ssm_parameter.amz2-ami-primary.value
  instance_type = "t2.medium"
  key_name = aws_key_pair.primary-key.key_name
  associate_public_ip_address = false
  subnet_id = aws_subnet.primary-subnet-01.id
  tags = {
    Name = join("-", ["db-instance", count.index + 1, "a"])
  }
}


resource "aws_instance" "web-server-saz-a" {
  provider = aws.secondary
  count = 2
  ami = data.aws_ssm_parameter.amz2-ami-secondary.value
  instance_type = "t2.micro"
  key_name = aws_key_pair.secondary-key.key_name
  associate_public_ip_address = true
  subnet_id = aws_subnet.secondary-subnet-01.id
  tags = {
    Name = join("-", ["web-server", count.index + 1, "a"])
  }
}

resource "aws_instance" "web-server-saz-b" {
  provider = aws.secondary
  count = 2
  ami = data.aws_ssm_parameter.amz2-ami-secondary.value
  instance_type = "t2.micro"
  key_name = aws_key_pair.secondary-key.key_name
  associate_public_ip_address = true
  subnet_id = aws_subnet.secondary-subnet-02.id
  tags = {
    Name = join("-", ["web-server", count.index + 1, "b"])
  }
}

resource "aws_instance" "db-saz-a" {
  provider = aws.secondary
  count = 0
  ami = data.aws_ssm_parameter.amz2-ami-secondary.value
  instance_type = "t2.medium"
  key_name = aws_key_pair.secondary-key.key_name
  associate_public_ip_address = false
  subnet_id = aws_subnet.secondary-subnet-01.id
  tags = {
    Name = join("-", ["db-instance", count.index + 1, "a"])
  }
}
