data "azurerm_client_config" "current_client" {}

data "azurerm_resource_group" "current_rg"{
    name = var.rg_name
}

data "azurerm_key_vault" "key_vault" {
    name = var.keyvault_name
    resource_group_name = var.rg_name
}

data "azurerm_key_vault_key" "encryption_key" {
  name = var.encryption_key
  key_vault_id = data.azurerm_key_vault.key_vault.id
}