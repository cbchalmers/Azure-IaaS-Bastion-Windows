resource "random_id" "storage_account" {
  byte_length = 10
}

resource "azurerm_storage_account" "storageaccount" {
  name                      = random_id.storage_account.hex
  resource_group_name       = azurerm_resource_group.resource_group.name
  location                  = azurerm_resource_group.resource_group.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "StorageV2"
  enable_https_traffic_only = true

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

}