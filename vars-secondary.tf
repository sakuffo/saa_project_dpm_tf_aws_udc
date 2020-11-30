
variable "secondary" {
  type = object({
    region            = string
    public-subnet-01  = string
    public-subnet-02  = string
    private-subnet-01 = string
    private-subnet-02 = string
    s3-bucket-01      = string
  })
  default = {
    region            = "us-west-2"
    public-subnet-01  = "us-west-2a"
    public-subnet-02  = "us-west-2b"
    private-subnet-01 = "us-west-2b" # swapped azs since I am only launching 1 m4 per vpc
    private-subnet-02 = "us-west-2a"
    s3-bucket-01      = "saa-udc-secondary-bucket-task-5"
  }
}

variable "secondary-web" {
  type = object({
    instance-type = string
    count         = number
    storage-type  = string
    storage-size  = number
    user_data_path  = string
  })
  default = {
    instance-type = "t2.micro"
    count         = 1
    storage-type  = "gp2"
    storage-size  = 10
    user_data_path = "./user_data/web-svr-svpc.sh"
  }
}
variable "secondary-db" {
  type = object({
    instance-type = string
    count         = number
    storage-size  = number
    storage-type  = string
    user_data_path  = string
  })
  default = {
    instance-type = "t3.medium"
    count         = 0
    storage-size  = 20
    storage-type  = "gp2"
    user_data_path = "./user_data/database.sh"
  }
}

