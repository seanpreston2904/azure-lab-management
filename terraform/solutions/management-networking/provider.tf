terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 4.81"
        }
    }

    # Settings are supplied by the reusable workflows via -backend-config
    backend "azurerm" {}
}

provider "azurerm" {
    resource_provider_registrations = "none"
    features {}
    storage_use_azuread = true
}