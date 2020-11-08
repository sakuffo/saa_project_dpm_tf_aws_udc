terraform {
    backend "remote" {
        hostname = "app.terraform.io"
        organization = "saa-udc"

        workspaces {
            name = "saa_project_dpm_tf_aws_udc"
        }
    }
}