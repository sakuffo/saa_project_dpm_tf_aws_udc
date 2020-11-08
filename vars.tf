variable "primary-region" {
  type    = string
  default = "us-east-1"
}

variable "primary-public-subnet-01" {
  type    = string
  default = "us-east-1a"
}

variable "primary-public-subnet-02" {
  type    = string
  default = "us-east-1b"
}

variable "secondary-region" {
  type    = string
  default = "us-west-2"
}

variable "secondary-public-subnet-01" {
  type    = string
  default = "us-west-2a"
}

variable "secondary-public-subnet-02" {
  type    = string
  default = "us-west-2b"
}

variable "amzn2-ami-x86" {
  type    = string
  default = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

variable "web-instance-type" {
  type = string
  default = "t2.micro"
}

variable "db-instance-type" {
  type = string
  default = "t3.medium"
}

variable "web-pvpc-count" {
  type = number
  default = 1
}

variable "web-svpc-count" {
  type = number
  default = 1
}

variable "db-pvpc-count" {
  type = number
  default = 1
}

variable "db-svpc-count" {
  type = number
  default = 1
}

variable "storage-type" {
  type = string
  default = "gp2"
}

variable "web-storage" {
  type = number
  default = 10
}

variable "db-storage" {
  type = number
  default = 20
}