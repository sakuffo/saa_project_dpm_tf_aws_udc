variable "primary" {
  type = object({
    region            = string
    public-subnet-01  = string
    public-subnet-02  = string
    private-subnet-01 = string
    private-subnet-02 = string
    s3-bucket-01      = string
  })
  default = {
    region            = "us-east-1"
    public-subnet-01  = "us-east-1a"
    public-subnet-02  = "us-east-1b"
    private-subnet-01 = "us-east-1a"
    private-subnet-02 = "us-east-1b"
    s3-bucket-01      = "saa-udc-primary-bucket-task-5"
  }
}

variable "primary-web" {
  type = object({
    instance-type  = string
    count          = number
    storage-type   = string
    storage-size   = number
    user_data_path = string
    ami            = string
  })
  default = {
    instance-type  = "t2.micro"
    count          = 1
    storage-type   = "gp2"
    storage-size   = 10
    user_data_path = "./user_data/web-svr-pvpc.sh"
    ami            = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  }
}

variable "primary-db" {
  type = object({
    instance-type  = string
    count          = number
    storage-size   = number
    storage-type   = string
    user_data_path = string
    ami            = string
  })
  default = {
    instance-type  = "t3.medium"
    count          = 0
    storage-size   = 20
    storage-type   = "gp2"
    ami            = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
    user_data_path = "./user_data/database.sh"
  }
}
