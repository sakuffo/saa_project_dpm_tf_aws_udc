# PROJECT Design, Provision and Monitor AWS Infrastructure at Scale
## TASK 5 PART 1

Objective is to create an AWS environment with terraform
Meets Specification simply asks to deploy against an exisiting VPC, using an exisiting public subnet. The payload is simply 4 x t2.micro EC2 instances and 2 m4.large EC2 instaces

To kick it up a notch i decide to include some extra spec, some of which are included from the extra credit for Project Ruburic.
Due to time constraints and a family emergency, I had to bring back the scope to submit the project. Stretch goals will be implemented over time.
## Meets Specification:

1.  Use Terraform to provision in two regions
    - A VPC
    - Public Subnets in each AZ (a & b)
    - Private Subnets in each AZ
    - EC2 instances. 2 x t2.micros with 10GB EBS per region and 1 m4.large with 20GB EBS
    - S3 buckets in each region (eventually to be used for image storage)

2. Breakout the terraform files into modules, including at least
    - vars.tf
    - outputs.tf
    - main.tf
    - more tf files where included

The idea is to make sure everything I am doing in the course could actually be used real world

## Known issues
-   Terraform Cloud/S3 are coded with my names for these resources. As such to use the code you have to switch out the backend_exmaple.tf file with
    something that works for you. Same with the S3 resources.
-   There are some advanced outputs that will require dynamic data generation. As such to allow for smooth destoryes they have been commented out.
    To make them work, simply uncomment them. However, the data will have to be commented out to allow for destroys as the destroy action does not delete

## Stretch - WIP for after course

- Refactor code to be more real world
    - Make the web instances have an actual web app rather than just simple html string
    - Connect the web app to the databaes
    - Convert the databases from EC2 instances to RDS instances
    - Include a lambda function to upload images
    - Include a lambda function to retrieve images
