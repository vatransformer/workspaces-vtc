# COMMON VARIABLES

variable "target_account" {
  description = "Target AWS account ID."
  sensitive   = true
  type        = string
  default     = null
}

variable "target_region" {
  description = "Target AWS region name."
  sensitive   = true
  type        = string
  default     = null
}

variable "target_role" {
  description = "Target AWS IAM role name to be assumed."
  sensitive   = true
  type        = string
  default     = null
}

variable "project" {
  description = "Project name."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

# STACK VARIABLES


variable "workspaces" {
  type    = list(any)
  default = []
}

variable "default_ou" {
  description = "OU for Workspaces."
  type        = string
}

variable "enable_internet_access" {
  description = "Defines if internet access is enabled."
  type        = bool
  default     = true
}

variable "enable_maintenance_mode" {
  description = "Defines if maintenance mode is enabled."
  type        = bool
  default     = true
}

variable "enable_local_administrator" {
  description = "Defines if local admin permissions are granted for users."
  type        = bool
  default     = true
}

variable "bundle_ids" {
  type        = map(any)
  description = "Workspaces Bundle IDs map"
  default = {
    "windows-10-performance-10gb-bundle-dev"  = "wsb-cbpq0z0c3"
    "windows-10-performance-10gb-bundle-prod" = "wsb-xd4vfr46m"
  }
}
