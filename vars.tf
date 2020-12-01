variable "udc_default_tags" {
  type = map
  default = {
    "courseWork" : "true",
    "entity" : "udacity",
    "program" : "aws-architect"
  }
  description = "Tags to mark all resources for the course"
}

variable "ssh_path" {
  type    = string
  default = "~/.ssh/udc_rsa.pub"
}

variable "db_user_data_path" {
  type    = string
  default = "./user_data/database.sh"
}

variable "http-traffic-port" {
  type    = number
  default = 80
}

variable "ssh-traffic-port" {
  type    = number
  default = 22
}

variable "database-traffic-port" {
  type    = number
  default = 3306
}

variable "public_subnet_count" {
  type    = number
  default = 2
}
