terraform {
  required_providers {
    anypoint = {
      source  = "mulesoft-anypoint/anypoint"
      version = "1.5.5"
    }
  }
}
provider "anypoint" {
}

variable "org_id" {
  type    = string
  default = "fb623940-e3a3-4944-8c21-ab28e5676f82"
}

variable "env_id" {
  type    = string
  default = "ea0b63b3-0da5-4d56-88d1-15056ec2bb55"
}
# resource "anypoint_env" "environment" {
#   org_id = var.org_id # environment related business group
#   name   = "TERRAF"    # environment name
#   type   = "sandbox"  # environment type : sandbox/production
# }
resource "anypoint_connected_app" "my_conn_app" {
  name        = "itsownbehalfd"
  grant_types = ["client_credentials"]
  audience    = "internal"

  scope {
    scope = "profile"
  }

  scope {
    scope  = "aeh_admin"
    org_id = var.org_id
  }

  scope {
    scope  = "read:audit_logs"
    org_id = var.org_id
  }

  scope {
    scope  = "view:environment"
    org_id = var.org_id
    env_id = var.env_id
  }

  scope {
    scope  = "edit:environment"
    org_id = var.org_id
    env_id = var.env_id
  }
}