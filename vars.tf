variable "primary" {
  type = object({
    region            = string
    public-subnet-01  = string
    public-subnet-02  = string
    private-subnet-01 = string
    private-subnet-02 = string
  })
  default = {
    region            = "us-east-1"
    public-subnet-01  = "us-east-1a"
    public-subnet-02  = "us-east-1b"
    private-subnet-01 = "us-east-1a"
    private-subnet-02 = "us-east-1b"
  }
}

variable "secondary" {
  type = object({
    region            = string
    public-subnet-01  = string
    public-subnet-02  = string
    private-subnet-01 = string
    private-subnet-02 = string
  })
  default = {
    region            = "us-west-2"
    public-subnet-01  = "us-west-2a"
    public-subnet-02  = "us-west-2b"
    private-subnet-01 = "us-west-2a"
    private-subnet-02 = "us-west-2b"
  }
}
variable "primary-web" {
  type = object({
    instance-type = string
    count         = number
    storage-type  = string
    storage-size = number
  })
  default = {
    instance-type = "t2.micro"
    count         = 1
    storage-type = "gp2"
    storage-size  = 10
  }
}

variable "primary-db" {
  type = object({
    instance-type = string
    count         = number
    storage-size  = number
    storage-type  = string
  })
  default = {
    instance-type = "t2.medium"
    count         = 1
    storage-size  = 20
    storage-type = "gp2"
  }
}

variable "secondary-web" {
  type = object({
    instance-type = string
    count         = number
    storage-type  = string
    storage-size = number
  })
  default = {
    instance-type = "t2.micro"
    count         = 1
    storage-type  = "gp2"
    storage-size  = 10
  }
}

variable "secondary-db" {
  type = object({
    instance-type = string
    count         = number
    storage-size  = number
    storage-type  = string
  })
  default = {
    instance-type = "t2.medium"
    count         = 1
    storage-size  = 20
    storage-type = "gp2"
  }
}

variable "amzn2-ami-x86" {
  type    = string
  default = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}