terraform {
  required_providers {
    anypoint = {
      source = "mulesoft-anypoint/anypoint"
      version = "1.5.5"
    }
  }
}
provider "anypoint" {
}

variable "org_id" {
    type = string
}

variable "env_id" {
    type = string
    default = "ea0b63b3-0da5-4d56-88d1-15056ec2bb55"
}
resource "anypoint_env" "env" {
  org_id = var.ORG_ID   # environment related business group
  name = "TERRA"                  # environment name
  type = "sandbox"              # environment type : sandbox/production
}
resource "anypoint_connected_app" "my_conn_app_its_own_behalf" {
    name = "itsownbehalf"
    grant_types = ["client_credentials"]
    audience = "internal"

    scope {
        scope = "profile"
    }

    scope {
        scope = "aeh_admin"
        org_id = var.org_id
    }

    scope {
        scope = "read:audit_logs"
        org_id = var.org_id
    }

    scope {
        scope = "view:environment"
        org_id = var.org_id
        env_id = var.env_id
    }

    scope {
        scope = "edit:environment"
        org_id = var.org_id
        env_id = var.env_id
    }
}