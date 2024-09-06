resource "azurerm_key_vault" "vm_kv" {
  name = "binvmkv1"
  location = var.rg_location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id = data.azurerm_client_config.current_client.tenant_id
  sku_name = "premium"
  enabled_for_disk_encryption = true
  purge_protection_enabled = false
}

resource "azurerm_key_vault_access_policy" "service_principal" {
  key_vault_id = azurerm_key_vault.vm_kv.id
  tenant_id = data.azurerm_client_config.current_client.tenant_id
  object_id = data.azurerm_client_config.current_client.object_id

  key_permissions = [
    "Create",
    "Encrypt",
    "Decrypt",
    "Delete",
    "Get",
    "Update",
    "List",
    "Rotate",
    "Purge",
    "Update",
    "GetRotationPolicy",
    "SetRotationPolicy"
  ]

  secret_permissions = [
    "Get",
    "Delete",
    "Set",
    "List",
    "Purge",
  ]
}

resource "azurerm_key_vault_key" "vm_kv_key" {
  name = "binvmkvkey"
  key_vault_id = azurerm_key_vault.vm_kv.id
  key_type = "RSA"
  key_size = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  depends_on = [
    azurerm_key_vault_access_policy.service_principal
   ]
}