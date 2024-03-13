# BACKEND

terraform {
  backend "s3" {
    bucket         = "terraform-state-843217052313-us-east-1"
    key            = "workspaces/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locktable"
    encrypt        = true
  }
}
