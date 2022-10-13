terraform {
  required_version = ">= 1.3.2"

  backend "local" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.26.0"
    }

    azapi = {
      source  = "Azure/azapi"
      version = "1.0.0"
    }
  }
}

provider "azurerm" {
  features {
    # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/features-block
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }

    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }

    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "azurerm" {
  alias           = "ssu"
  subscription_id = "94b0cff0-edee-4f6f-96dc-03ec2eecfc35"
  tenant_id       = "72f988bf-86f1-41af-91ab-2d7cd011db47"

  features {}
}
