terraform {
  backend "remote" {
    organization = "saa-udc"

    workspaces {
      name = "saa_project_dpm_tf_aws_udc"
    }
  }
}