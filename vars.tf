variable "udc_default_tags" {
  type = map
  default = {
    "courseWork" : "true",
    "entity" : "udacity",
    "program" : "aws-architect"
  }
  description = "Tags to mark all resources for the course"
}

variable "amzn2-ami-x86" {
  type    = string
  default = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

variable "ssh_path" {
  type    = string
  default = "~/.ssh/udc_rsa.pub"
}

variable "db_user_data_path" {
  type    = string
  default = "./user_data/database.sh"
}