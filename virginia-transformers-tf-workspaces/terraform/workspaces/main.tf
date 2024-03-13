# LOCALS

locals {
  prefix = !strcontains(terraform.workspace, var.project) ? join("-", [terraform.workspace, var.project]) : terraform.workspace
  tags = merge(var.tags, {
    "Environment" = terraform.workspace
    "Project"     = var.project
    "Region"      = var.target_region
    "Account"     = var.target_account
  })
}

# MODULES & RESOURCES
resource "aws_workspaces_directory" "workspaces_directory" {
  provider     = aws.target
  directory_id = data.terraform_remote_state.directory.outputs.adconnector_directory_id
  subnet_ids   = data.terraform_remote_state.vpc.outputs.private_subnets

  tags = var.tags

  workspace_access_properties {
    device_type_android    = "ALLOW"
    device_type_chromeos   = "ALLOW"
    device_type_ios        = "ALLOW"
    device_type_linux      = "ALLOW"
    device_type_osx        = "ALLOW"
    device_type_web        = "ALLOW"
    device_type_windows    = "ALLOW"
    device_type_zeroclient = "ALLOW"
  }

  workspace_creation_properties {
    default_ou                          = var.default_ou
    enable_internet_access              = var.enable_internet_access
    enable_maintenance_mode             = var.enable_maintenance_mode
    user_enabled_as_local_administrator = var.enable_local_administrator
  }
  depends_on = [aws_iam_role_policy_attachment.workspaces_default_service_access]
}

data "aws_iam_policy_document" "workspaces" {
  provider = aws.target
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["workspaces.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "workspaces_default" {
  provider             = aws.target
  name                 = "workspaces_DefaultRole"
  assume_role_policy   = data.aws_iam_policy_document.workspaces.json
  max_session_duration = 14400
}

resource "aws_iam_role_policy_attachment" "workspaces_default_service_access" {
  provider   = aws.target
  role       = aws_iam_role.workspaces_default.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonWorkSpacesServiceAccess"
}

resource "aws_workspaces_workspace" "workspace" {
  provider = aws.target
  for_each = { for x in var.workspaces : x.user_name => x }

  directory_id = aws_workspaces_directory.workspaces_directory.id
  user_name    = each.value.user_name
  bundle_id    = var.bundle_ids[each.value.bundle_name]

  workspace_properties {
    running_mode                              = try(each.value.auto_stop, null) != null ? "AUTO_STOP" : "ALWAYS_ON"
    compute_type_name                         = try(each.value.compute_type, null) != null ? lookup(each.value, "compute_type", "PERFORMANCE") : "PERFORMANCE"
    running_mode_auto_stop_timeout_in_minutes = try(each.value.auto_stop, null) != null ? 60 : null
    user_volume_size_gib                      = try(each.value.user_volume, null) != null ? lookup(each.value, "user_volume", "10") : "10"
  }

  tags = merge(var.tags, { "Name" = "${each.key}-workspace" })
}
