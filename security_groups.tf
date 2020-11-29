resource "aws_security_group" "primary-web-tier" {
  provider    = aws.primary
  name        = "primary-web-tier"
  description = "Web Tier SG"
  vpc_id      = aws_vpc.primary-vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.primary-vpc.cidr_block, "0.0.0.0/0"] #SSH from anywhere not secure. However rsa private key needed.
  }

  ingress {
    description = "HTTP Traffc"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.primary-vpc.cidr_block, "0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.udc_default_tags,
    {
      Name = "primary-web-tier"
    }
  )
}

resource "aws_security_group" "primary-db-tier" {
  provider    = aws.primary
  name        = "primary-db-tier"
  description = "DB Tier SG"
  vpc_id      = aws_vpc.primary-vpc.id

  ingress {
    description = "Web-Tier to DB-Tier Traffic"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.udc_default_tags,
    {
      Name = "primary-db-tier"
    }
  )
}

resource "aws_security_group" "secondary-web-tier" {
  provider    = aws.secondary
  name        = "secondary-web-tier"
  description = "Web Tier SG"
  vpc_id      = aws_vpc.secondary-vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.secondary-vpc.cidr_block, "0.0.0.0/0"] #SSH from anywhere not secure. However rsa private key needed.
  }

  ingress {
    description = "HTTP Traffc"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.secondary-vpc.cidr_block, "0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.udc_default_tags,
    {
      Name = "secondary-web-tier"
    }
  )
}

resource "aws_security_group" "secondary-db-tier" {
  provider    = aws.secondary
  name        = "secondary-db-tier"
  description = "DB Tier SG"
  vpc_id      = aws_vpc.secondary-vpc.id

  ingress {
    description = "Web-Tier to DB-Tier Traffic"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.udc_default_tags,
    {
      Name = "secondary-db-tier"
    }
  )
}
