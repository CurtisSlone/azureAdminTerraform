data "azurerm_client_config" "current_client" {}

data "azurerm_key_vault" "key_vault" {
    name = "binvmkv1"
    resource_group_name = var.rg_name
}

data "azurerm_key_vault_key" "encryption_key" {
  name = "binvmkvkey"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}