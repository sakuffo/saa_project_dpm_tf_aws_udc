# EC2 AMI images
data "aws_ssm_parameter" "amz2-ami-secondary" {
  provider = aws.secondary
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# EC2 Secondary-VPC Instance ssh keys
resource "aws_key_pair" "secondary-key" {
  provider   = aws.secondary
  key_name   = "udac"
  public_key = file(var.ssh_path)
}

# EC2 Secondary-VPC Instance creation

# Instances in Secondary-VPC public az-a
resource "aws_instance" "web-server-saz-a" {
  provider                    = aws.secondary
  count                       = var.secondary-web.count
  ami                         = data.aws_ssm_parameter.amz2-ami-secondary.value
  instance_type               = var.secondary-web.instance-type
  key_name                    = aws_key_pair.secondary-key.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.secondary-subnet-01.id
  vpc_security_group_ids      = [aws_security_group.secondary-web-tier.id]
  user_data                   = file(var.secondary-web.user_data_path)
  tags = merge(
    var.udc_default_tags,
    {
      Name = join("-", ["Udacity t2 - web-server", count.index + 1, "a"])
      Tier = "Web"
    }
  )
  root_block_device {
    volume_type = var.secondary-web.storage-type
    volume_size = var.secondary-web.storage-size
  }
}

# Instances in Secondary-VPC public az-b
resource "aws_instance" "web-server-saz-b" {
  provider                    = aws.secondary
  count                       = var.secondary-web.count
  ami                         = data.aws_ssm_parameter.amz2-ami-secondary.value
  instance_type               = var.secondary-web.instance-type
  key_name                    = aws_key_pair.secondary-key.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.secondary-subnet-02.id
  vpc_security_group_ids      = [aws_security_group.secondary-web-tier.id]
  user_data                   = file(var.secondary-web.user_data_path)
  tags = merge(
    var.udc_default_tags,
    {
      Name = join("-", ["Udacity t2 - web-server", count.index + 1, "b"])
      Tier = "Web"
    }
  )
  root_block_device {
    volume_type = var.secondary-web.storage-type
    volume_size = var.secondary-web.storage-size
  }
}

# Instances in Secondary-VPC private az-b
resource "aws_instance" "db-saz-b" {
  provider                    = aws.secondary
  count                       = var.secondary-db.count
  ami                         = data.aws_ssm_parameter.amz2-ami-secondary.value
  instance_type               = var.secondary-db.instance-type
  key_name                    = aws_key_pair.secondary-key.key_name
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.secondary-subnet-02.id
  vpc_security_group_ids      = [aws_security_group.secondary-db-tier.id]
  user_data                   = file(var.secondary-db.user_data_path)
  tags = merge(
    var.udc_default_tags,
    {
      Name = join("-", ["Udacity m4 - db-instance", count.index + 1, "b"])
      Tier = "DB"
    }
  )
  root_block_device {
    volume_type = var.secondary-db.storage-type
    volume_size = var.secondary-db.storage-size
  }
}