provider "azurerm" {
  version         = "2.12.0"
  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
  features {
  }
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_prefix}-BASTION-WIN-rg"
  location = var.resource_location
}