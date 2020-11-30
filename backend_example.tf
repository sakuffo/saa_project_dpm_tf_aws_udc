# Please note that this will have to be updated with you backend details
terraform {
  backend "remote" {
    organization = "saa-udc"

    workspaces {
      name = "saa_project_dpm_tf_aws_udc" #This will have to be updated for your specific workspace if you use Teraform cloud
    }
  }
}