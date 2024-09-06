data "azurerm_client_config" "current_client" {}

data "azurerm_resource_group" "current_rg"{
    name = var.rg_name
}