# PROJECT Design, Provision and Monitor AWS Infrastructure at Scale
## TASK 5 PART 1

Objective is to create an AWS environment with terraform
Meets Specification simply asks to deploy against an exisiting VPC, using an exisiting public subnet. The payload is simply 4 x t2.micro EC2 instances and 2 m4.large EC2 instaces

To kick it up a notch i decide to include some extra spec, some of which are included from the extra credit for Project Ruburic.

## Meets Specification:

1.  Use Terraform to provision in two regions
    - A VPC
    - Public Subnets
    - EC2 instances with 20GB EBS storage (2 t2.micros per region and 1 m4.large[for cost reasons I will use t2.mediums instead])
    - S3 buckets in each region

2. Breakout the terraform files into modules, including at least
    - vars.tf
    - outputs.tf
    - main.tf

The idea is to make sure everything I am doing in the course could actually be used real world

## Stretch - WIP

3. Refactor code to be more real world
    - replace the empty t2.micro instances with t3.micros that are bootstrapped with Wordpress front end (my learning acount does not allow for other images)
    - replace the t3.medium instance with an RDS database with replication to second VPC
    - put the wordpress front ends behind a load balance

## Notable issues

Since I am making these sites across VPCs
Due to time constraints I have not yet made the database an RDS instance. As such I have two self contained apps on two different VPCs.
This will be fixed over time but for time reasons, I have pto put it on the WIP
## WIP

- Route53
- Cloudfront
- RDS
