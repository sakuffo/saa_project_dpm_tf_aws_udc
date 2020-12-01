# Primary Subnet Public AZ-1
resource "aws_subnet" "primary-subnet-01" {
  provider                = aws.primary
  vpc_id                  = aws_vpc.primary-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.primary.public-subnet-01
  map_public_ip_on_launch = true
  tags = merge(
    var.udc_default_tags,
    {
      Name = "Primary Public Subnet 01"
    }
  )
}

# Primary Subnet Public AZ-2
resource "aws_subnet" "primary-subnet-02" {
  provider                = aws.primary
  vpc_id                  = aws_vpc.primary-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.primary.public-subnet-02
  map_public_ip_on_launch = true

  tags = merge(
    var.udc_default_tags,
    {
      Name = "Primary Public Subnet 02"
    }
  )
}
# Primary Subnet Private AZ-1
resource "aws_subnet" "primary-private-subnet-01" {
  provider          = aws.primary
  vpc_id            = aws_vpc.primary-vpc.id
  cidr_block        = "10.0.100.0/24"
  availability_zone = var.primary.private-subnet-01

  tags = merge(
    var.udc_default_tags,
    {
      Name = "Primary Private Subnet 01"
    }
  )
}

# Secondary Subnet Public AZ-1
resource "aws_subnet" "secondary-subnet-01" {
  provider          = aws.secondary
  vpc_id            = aws_vpc.secondary-vpc.id
  cidr_block        = "172.10.1.0/24"
  availability_zone = var.secondary.public-subnet-01

  tags = merge(
    var.udc_default_tags,
    {
      Name = "Secondary Public Subnet 01"
    }
  )
}

# Secondary Subnet Public AZ-2
resource "aws_subnet" "secondary-subnet-02" {
  provider          = aws.secondary
  vpc_id            = aws_vpc.secondary-vpc.id
  cidr_block        = "172.10.2.0/24"
  availability_zone = var.secondary.public-subnet-02

  tags = merge(
    var.udc_default_tags,
    {
      Name = "Secondary Public Subnet 02"
    }
  )
}

# Secondary Subnet Private AZ-2 (There is no AZ-1 in this case)
resource "aws_subnet" "primary-private-subnet-02" {
  provider          = aws.secondary
  vpc_id            = aws_vpc.secondary-vpc.id
  cidr_block        = "172.10.3.0/24"
  availability_zone = var.secondary.private-subnet-01

  tags = merge(
    var.udc_default_tags,
    {
      Name = "Secondary Private Subnet 01"
    }
  )
}
