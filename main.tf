provider "azurerm" {
  features {}
}

# define your own storage_account_name and export ARM_ACCESS_KEY
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstates"
    storage_account_name = "tfstatesaldenso"
    container_name       = "terraform"
    key                  = "terraform_share.tfstate"
  }
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_storage_account" "main" {
  name                     = "${var.prefix}storaccount"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_share" "main" {
  name                 = "${var.prefix}storshare"
  storage_account_name = azurerm_storage_account.main.name
  quota                = 1
}
