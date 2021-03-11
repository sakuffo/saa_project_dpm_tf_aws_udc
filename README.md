## Notes for the AWS Study Group

I did this project as one of the final things required to pass my bootcamp. They told us what to build in general, but we had to figured out all the code for it and how we wanted to do it. This was one I was first learning terraform so lots of mistakes as far as keeping the code and file structure clean. However, it works!

Couple things to note. I will record a video explainer next week 

1.  I built this with terraform 0.13x and tested it with 0.14.7 today but you may need to lock some versions

2.  I built this without really understanding all the best practices
    - Typically rather than manually configuring everything you would built out modules that can be reused
    - Without modules this is more fragile than it needs to be, but it does come up
    - My file structure is also not best practicies.
    - I will probably go back at some point and refactor things

3.  Some SSH stuff that will need to be done
    - Create a key with a public file
    - put that key path in vars.tf in the ssh_path variable
    - **You can also remove references to SSH keys if you don't think you will need to ssh into the hosts**

4.  You will have to go into vars.tf, vars-primary.tf and vars-secondary.tf and change variable names as needed.
    Most important one to change is the s3 bucket name due to global bucket name rules.

5.  I put this in my free account and it cost a few dollars over a week or so till the project got inspected and graded.
    - I have listed what I created in the next section if you want to do an inspection

6.  The way this is done it uses a local statefile. Local statefiles are not recommended.
    In backend_example.tf I have example code on how you would use with terraform cloud for statemanagement.
    And easier one to use is an S3 bucket. Only issue there is you have to create it first. But you can use this doc
    to put an s3 backend so that your statefile is not local to your system
    https://www.terraform.io/docs/language/settings/backends/s3.html

# PROJECT Design, Provision and Monitor AWS Infrastructure at Scale
## TASK 5 PART 1

Objective is to create an AWS environment with terraform
Meets Specification simply asks to deploy against an exisiting VPC, using an exisiting public subnet. The payload is simply 4 x t2.micro EC2 instances and 2 m4.large EC2 instaces

To kick it up a notch i decide to include some extra spec, some of which are included from the extra credit for Project Ruburic.
Due to time constraints, I had to bring back the scope to submit the project. Stretch goals will be implemented over time.
## Project Specification:

1.  Used Terraform to provision in two regions each with:
    - ***NB** Every resource that supports tags is tagged with*:
    - - "courseWork" : "true",
    - - "entity" : "udacity",
    - - "program" : "aws-architect"
    - - *This allows all provisioned resources to be found with their tags and reduces chances that I will forget a resource. I can just search for the tag and confirm*

    - **A VPC**
    - **Public Subnets in each AZ (a & b)**
    - **Private Subnets in each AZ (a & b)**
    - **Application loab balancer (ALB)**
    - **ALB listeners**
    - - Please note that Web traffic is only HTTP (Port 80) 
    - - Have not provisioned SSL Cert required for an HTTPS
    - **Target Group**
    - **EC2 instances**
    - - The min spec calls for 6 minimum so I have
        provisioned 2 x t2.micro and 1 x m4.large per vpc/per region
        this can be configured through the count attribute in the 
        instance variables in vars-*.tf
    - - The web instances have 10GB EBS, gp2
    - - The db instances have 20GB EBS, gp2
    - **Security Groups** 
    - They allow for all egress and following ingress:
    - - Web Tier SG:
    - - - 22 Port access from anywhere (*Not secure however a pem is required)
    - - - 80 HTTP access from anywhere
    - - DB Tier SG:
    - - - 3306 Port access from Web Tier SG for MySQL access
    - **Routing and Routing Tables**
    - **User data for the EC2 instances**
    - **SSH Keys** 
    - - * *Please note you will have to create a key with the same name as what is in vars.tf*
    - **S3 buckets** 
    - - Buckets in each region. Eventually to be used for image storage)
    - - *Due to bucket global naming this is commented out. Can be replaced with prefered buckets in the vars-primary/vars-secondary.tf file in the primary or secondary object. Field:s3-bucket-01*

2. Terraform files are broken out into
    - *NB: When necessary to keep the code from getting to dense tf files are split into if they are for the primary VPC or secondary VPC*
    - **main.tf**:
    - - This is where the VPCs and their alias are provisioned
    - **vars.tf**:
    - - This is where variables common to both VPCs are defined
    - **vars-primary.tf**:
    - - This is where variables used in Primary VPC are defined
    Where possible an object is used to minimize variables
    - **vars-secondary.tf**:
    - - This is where variables used in Secondary VPC are defined.
    Where possible an object is used to minimize variables.
    - **alb-primary.tf**:
    - - This is where the application load balancer items are defined for the primary VPC
    - **alb-secondary.tf**:
    - - This is where the application load balancer items are defined for the secondary VPC
    - **networks.tf**:
    - - This is where the subnets for both VPCs are defined.
    - **routes**
    - - This is where all the routes for both VPCs are defined
    - **s3_buckets.tf**:
    - - This is where the subnets for the s3 buckets are defined
    - **security_groups.tf**:
    - - This is where the security groups are defined
    - **outputs.tf**
    - - All tf outputs defined here
    - **backend_example.tf**
    - - If you wantto use a remote backend, you can update the values here. I have put the scaffold for a Terraform Cloud Backend
    - - If the environment is not state a local tfstate file is easier to use

The idea is to make sure everything I am doing in the course could actually be used real world. So while during the course I will stick closer to the minimum spec, i want to be able to use this and expand on it.

## Known issues
-   Terraform Cloud/S3 are coded with my names for these resources. As such to use the code you have to switch out the backend_exmaple.tf file with
    something that works for you. Same with the S3 resources.
-   If the environment this is applied against is not particularily static, you run the risk of the state file having resolution issues.
In this case you may need to purge the statefile.

## Work In Progress

- Refactor code to be more real world
    - Make the web instances have an actual web app rather than just simple html string
        - - explore what can be broken off into Lambda
    - Connect the web app to an RDS DB with read replica
    - Convert the databases from EC2 instances to RDS instances
    - Include a lambda function to upload images
    - Include a lambda function to retrieve images
    - Use an Autoscaling group
