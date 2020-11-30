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

variable "web-server-port" {
  type    = number
  default = 80
}

variable "web_instace_per_vpc" {
  type    = number
  default = 2
}
# This variable is a fix for a temporary chicken and egg problem
# attaching multiple instances to a target group with a single resource requires  it knows how many instances to iterate through
# To iterate through it needs to compute that come created instances
# This has not yet happened on greenfield deployment
# I will eventually fix this with some sot of for_each iterator however for time reasons I am going with this short fix