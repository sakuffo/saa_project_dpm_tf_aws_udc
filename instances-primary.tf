## EC2 Instance creation
data "aws_ssm_parameter" "amz2-ami-primary" {
  provider = aws.primary
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_key_pair" "primary-key" {
  provider   = aws.primary
  key_name   = "udc_rsa"
  public_key = file("~/.ssh/udc_rsa.pub")
}

resource "aws_instance" "web-server-paz-a" {
  provider                    = aws.primary
  count                       = var.web-pvpc-count
  ami                         = data.aws_ssm_parameter.amz2-ami-primary.value
  instance_type               = var.web-instance-type
  key_name                    = aws_key_pair.primary-key.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.primary-subnet-01.id
  root_block_device {
    volume_type = var.storage-type
    volume_size = var.web-storage
  }

  tags = {
    Name = join("-", ["web-server", count.index + 1, "a"])
  }
}

resource "aws_instance" "web-server-paz-b" {
  provider                    = aws.primary
  count                       = var.web-pvpc-count
  ami                         = data.aws_ssm_parameter.amz2-ami-primary.value
  instance_type               = var.web-instance-type
  key_name                    = aws_key_pair.primary-key.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.primary-subnet-02.id
  tags = {
    Name = join("-", ["web-server", count.index + 1, "b"])
  }
  root_block_device {
    volume_type = var.storage-type
    volume_size = var.web-storage
  }
}

resource "aws_instance" "db-paz-a" {
  provider                    = aws.primary
  count                       = var.db-pvpc-count
  ami                         = data.aws_ssm_parameter.amz2-ami-primary.value
  instance_type               = var.db-instance-type
  key_name                    = aws_key_pair.primary-key.key_name
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.primary-subnet-01.id
  tags = {
    Name = join("-", ["db-instance", count.index + 1, "a"])
  }
  root_block_device {
    volume_type = var.storage-type
    volume_size = var.db-storage
  }
}


