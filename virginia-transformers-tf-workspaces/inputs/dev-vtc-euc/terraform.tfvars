# COMMON VARIABLES

target_account = "896735828548"
target_region  = "us-east-1"
target_role    = "terraform-execution-role"
project        = "workspaces"

tags = {
  "Provisioner" = "Terraform"
  "Repository"  = "https://github.com/clearscale-team/virginia-transformers-tf-workspaces"
  "CostCenter"  = "Testing"
  "Owner"       = "ClearScale"
}

default_ou = "OU=Workspace BYOL,DC=vatransformer,DC=com"

# WORKSPACES DEFINITIONS
# By default all workspaces are set to AutoStop running mode and PERFORMANCE compute type

workspaces = [
  { user_name = "pkumar", bundle_name = "windows-10-performance-10gb-bundle-dev", auto_stop = "enabled" },
  { user_name = "deeng22", bundle_name = "windows-10-performance-10gb-bundle-dev", auto_stop = "enabled" },
  { user_name = "msharma", bundle_name = "windows-10-performance-10gb-bundle-dev", auto_stop = "enabled" }
  #{ user_name = "mikolaj", bundle_name = "windows-10-performance-10gb-bundle-dev", auto_stop = "enabled", compute_type = "POWER"}
]
