data "aws_ssm_parameter" "amz2-ami-secondary" {
  provider = aws.secondary
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_key_pair" "secondary-key" {
  provider   = aws.secondary
  key_name   = "udc_rsa"
  public_key = file("~/.ssh/udc_rsa.pub")
}


resource "aws_instance" "web-server-saz-a" {
  provider                    = aws.secondary
  count                       = var.secondary-web.count
  ami                         = data.aws_ssm_parameter.amz2-ami-secondary.value
  instance_type               = var.secondary-web.instance-type
  key_name                    = aws_key_pair.secondary-key.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.secondary-subnet-01.id
  tags = {
    Name = join("-", ["web-server", count.index + 1, "a"])
  }
  root_block_device {
    volume_type = var.secondary-web.storage-type
    volume_size = var.secondary-web.storage-size
  }
}

resource "aws_instance" "web-server-saz-b" {
  provider                    = aws.secondary
  count                       = var.secondary-web.count
  ami                         = data.aws_ssm_parameter.amz2-ami-secondary.value
  instance_type               = var.secondary-web.instance-type
  key_name                    = aws_key_pair.secondary-key.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.secondary-subnet-02.id
  tags = {
    Name = join("-", ["web-server", count.index + 1, "b"])
  }
  root_block_device {
    volume_type = var.secondary-web.storage-type
    volume_size = var.secondary-web.storage-size
  }
}

resource "aws_instance" "db-saz-b" {
  provider                    = aws.secondary
  count                       = var.secondary-db.count
  ami                         = data.aws_ssm_parameter.amz2-ami-secondary.value
  instance_type               = var.secondary-db.instance-type
  key_name                    = aws_key_pair.secondary-key.key_name
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.secondary-subnet-01.id
  tags = {
    Name = join("-", ["db-instance", count.index + 1, "b"])
  }
  root_block_device {
    volume_type = var.secondary-db.storage-type
    volume_size = var.secondary-db.storage-size
  }
}