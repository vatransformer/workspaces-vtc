data "terraform_remote_state" "vpc" {
  backend   = "s3"
  workspace = terraform.workspace
  config = {
    bucket = "terraform-state-843217052313-us-east-1"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "directory" {
  backend   = "s3"
  workspace = terraform.workspace
  config = {
    bucket = "terraform-state-843217052313-us-east-1"
    key    = "aws-ad-connector/terraform.tfstate"
    region = "us-east-1"
  }
}
