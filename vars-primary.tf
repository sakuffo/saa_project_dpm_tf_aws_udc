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
    instance-type = string
    count         = number
    storage-type  = string
    storage-size  = number
  })
  default = {
    instance-type = "t2.micro"
    count         = 1
    storage-type  = "gp2"
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
    instance-type = "m4.large"
    count         = 0
    storage-size  = 20
    storage-type  = "gp2"
  }
}

variable "primary_web_user_data_path" {
  type    = string
  default = "./user_data/web-svr-pvpc.sh"
}