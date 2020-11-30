## EC2 Primary-VPC AMI image
data "aws_ssm_parameter" "amz2-ami-primary" {
  provider = aws.primary
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}


## EC2 Primary-VPC Instance ssh keys
resource "aws_key_pair" "primary-key" {
  provider   = aws.primary
  key_name   = "udc_rsa"
  public_key = file(var.ssh_path)
}

## EC2 Primary-VPC Instance creation
resource "aws_instance" "web-server-paz-a" {
  provider                    = aws.primary
  count                       = var.primary-web.count
  ami                         = data.aws_ssm_parameter.amz2-ami-primary.value
  instance_type               = var.primary-web.instance-type
  key_name                    = aws_key_pair.primary-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.primary-web-tier.id]
  subnet_id                   = aws_subnet.primary-subnet-01.id
  user_data                   = file(var.primary_web_user_data_path)
  tags = merge(
    var.udc_default_tags,
    {
      Name = join("-", ["Udacity t2 - web-server", count.index + 1, "a"])
      Tier = "Web"
    }
  )
  root_block_device {
    volume_type = var.primary-web.storage-type
    volume_size = var.primary-web.storage-size
  }
}

resource "aws_instance" "web-server-paz-b" {
  provider                    = aws.primary
  count                       = var.primary-web.count
  ami                         = data.aws_ssm_parameter.amz2-ami-primary.value
  instance_type               = var.primary-web.instance-type
  key_name                    = aws_key_pair.primary-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.primary-web-tier.id]
  subnet_id                   = aws_subnet.primary-subnet-02.id
  user_data                   = file(var.primary_web_user_data_path)
  tags = merge(
    var.udc_default_tags,
    {
      Name = join("-", ["Udacity t2 - web-server", count.index + 1, "b"])
      Tier = "Web"
    }
  )
  root_block_device {
    volume_type = var.primary-web.storage-type
    volume_size = var.primary-web.storage-size
  }
}

resource "aws_instance" "db-paz-a" {
  provider                    = aws.primary
  count                       = var.primary-db.count
  ami                         = data.aws_ssm_parameter.amz2-ami-primary.value
  instance_type               = var.primary-db.instance-type
  key_name                    = aws_key_pair.primary-key.key_name
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.primary-subnet-01.id
  vpc_security_group_ids      = [aws_security_group.primary-db-tier.id]
  user_data                   = file(var.db_user_data_path)
  tags = merge(
    var.udc_default_tags,
    {
      Name = join("-", ["Udacity m4 - db-instance", count.index + 1, "a"])
      Tier = "DB"
    }
  )
  root_block_device {
    volume_type = var.primary-db.storage-type
    volume_size = var.primary-db.storage-size
  }

}


