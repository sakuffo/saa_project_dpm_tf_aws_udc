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
  default = "us-east-1a"
}

variable "secondary-public-subnet-02" {
  type    = string
  default = "us-east-1b"
}
