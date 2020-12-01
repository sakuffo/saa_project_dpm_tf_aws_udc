# Primary Web Tier Security group
# Allows Ingress:
# Port 22, from anywhere. This is not secure however an aws pem file from
# This vpc is needed so for this course it will suffice
# Port 80, form anywhere. There is no SSL cert provisioned to allow for HTTPS/443
# Egress is defaults
resource "aws_security_group" "primary-web-tier" {
  provider    = aws.primary
  name        = "primary-web-tier-sg"
  description = "Web Tier SG"
  vpc_id      = aws_vpc.primary-vpc.id

  ingress {
    description = "SSH"
    from_port   = var.ssh-traffic-port
    to_port     = var.ssh-traffic-port
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.primary-vpc.cidr_block, "0.0.0.0/0"] #SSH from anywhere not secure. However rsa private key needed.
    
  }

  ingress {
    description = "HTTP Traffc"
    from_port   = var.http-traffic-port
    to_port     = var.http-traffic-port
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
      Name = "primary-web-tier-sg"
    }
  )
}

# Primary DB Tier Security group
# Allows Ingress:
# Port 3306, from web tier Security group for potential database access

resource "aws_security_group" "primary-db-tier" {
  provider    = aws.primary
  name        = "primary-db-tier-sg"
  description = "DB Tier SG"
  vpc_id      = aws_vpc.primary-vpc.id

  ingress {
    description = "Web-Tier to DB-Tier Traffic"
    from_port   = var.database-traffic-port
    to_port     = var.database-traffic-port
    protocol    = "tcp"
    security_groups = [aws_security_group.primary-web-tier.id]
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
      Name = "primary-db-tier-sg"
    }
  )
}

# Secondary Web Tier Security group
# Allows Ingress:
# Port 22, from anywhere. This is not secure however an aws pem file from
# This vpc is needed so for this course it will suffice
# Port 80, form anywhere. There is no SSL cert provisioned to allow for HTTPS/443
# Egress is defaults
resource "aws_security_group" "secondary-web-tier" {
  provider    = aws.secondary
  name        = "secondary-web-tier-sg"
  description = "Web Tier SG"
  vpc_id      = aws_vpc.secondary-vpc.id

  ingress {
    description = "SSH"
    from_port   = var.ssh-traffic-port
    to_port     = var.ssh-traffic-port
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.secondary-vpc.cidr_block, "0.0.0.0/0"] #SSH from anywhere not secure. However rsa private key needed.
  }

  ingress {
    description = "HTTP Traffc"
    from_port   = var.http-traffic-port
    to_port     = var.http-traffic-port
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
      Name = "secondary-web-tier-sg"
    }
  )
}

# Secondary DB Tier Security group
# Allows Ingress:
# Port 3306, from web tier Security group for potential database access
resource "aws_security_group" "secondary-db-tier" {
  provider    = aws.secondary
  name        = "secondary-db-tier-sg"
  description = "DB Tier SG"
  vpc_id      = aws_vpc.secondary-vpc.id

  ingress {
    description = "Web-Tier to DB-Tier Traffic"
    from_port   = var.database-traffic-port
    to_port     = var.database-traffic-port
    protocol    = "tcp"
    security_groups = [aws_security_group.secondary-web-tier.id]
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
      Name = "secondary-db-tier-sg"
    }
  )
}
