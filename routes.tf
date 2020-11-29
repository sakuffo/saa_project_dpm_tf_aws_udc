# Primary Route table
resource "aws_route_table" "primary-vpc-rt" {
  provider = aws.primary
  vpc_id   = aws_vpc.primary-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary-vpc-igw.id
  }

  tags = merge(
    var.udc_default_tags,
    {
      Name = "Primary VPC RT"
    }
  )
}

# Primary route table association. This will createthe rt applied to all subnets built in VPC
resource "aws_main_route_table_association" "primary-vpc-rt-assoc" {
  provider       = aws.primary
  vpc_id         = aws_vpc.primary-vpc.id
  route_table_id = aws_route_table.primary-vpc-rt.id
}

#Primary Internet Gateway
resource "aws_internet_gateway" "primary-vpc-igw" {
  provider = aws.primary
  vpc_id   = aws_vpc.primary-vpc.id
  tags = merge(
    var.udc_default_tags,
    {
      Name = "primary-vpc-igw"
    }
  )
}

# Secondary Route table
resource "aws_route_table" "secondary-vpc-rt" {
  provider = aws.secondary
  vpc_id   = aws_vpc.secondary-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.secondary-vpc-igw.id
  }
  tags = merge(
    var.udc_default_tags,
    {
      Name = "Secondary VPC RT"
    }
  )
}

# Secondary route table association. This will createthe rt applied to all subnets built in VPC
resource "aws_main_route_table_association" "secondary-vpc-rt-assoc" {
  provider       = aws.secondary
  vpc_id         = aws_vpc.secondary-vpc.id
  route_table_id = aws_route_table.secondary-vpc-rt.id
}

#Secondary Internet Gateway
resource "aws_internet_gateway" "secondary-vpc-igw" {
  provider = aws.secondary
  vpc_id   = aws_vpc.secondary-vpc.id
  tags = merge(
    var.udc_default_tags,
    {
      Name = "secondary-vpc-igw"
    }
  )
}


