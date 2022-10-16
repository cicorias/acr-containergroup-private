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
  alias = "ssu-1"

  features {}
}
