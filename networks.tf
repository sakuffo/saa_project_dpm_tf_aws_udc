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
