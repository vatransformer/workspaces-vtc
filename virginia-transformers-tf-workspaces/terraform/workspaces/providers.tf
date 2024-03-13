# PROVIDERS

provider "aws" {}

provider "aws" {
  alias       = "target"
  region      = var.target_region
  max_retries = 100
  retry_mode  = "adaptive"
  assume_role {
    role_arn     = "arn:aws:iam::${var.target_account}:role/${var.target_role}"
    session_name = "terraform"
    duration     = "1h"
  }
}
