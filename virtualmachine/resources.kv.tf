resource "azurerm_key_vault" "vm_kv" {
  name = "${var.win_vm_name}_kv"
  location = azurerm_resource_group.rg.location
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
    "Delete",
    "Get",
    "Update"
  ]

  secret_permissions = [
    "Get",
    "Delete",
    "Set"
  ]
}

resource "azurerm_key_vault_key" "vm_kv_key" {
  name = "${var.win_vm_name}_kV_key"
  key_vault_id = azurerm_key_vault.vm_kv.id
  key_type = "RSA"
  key_size = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapkey",
    "verify",
    "wrapKey"
  ]

  depends_on = [
    azurerm_key_vault_access_policy.service_principal
   ]
}