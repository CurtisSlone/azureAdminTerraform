output "key_resource_id" {
  value = data.azurerm_key_vault_key.encryption_key.resource_id
}

output "key_name" {
  value = data.azurerm_key_vault_key.encryption_key.name
}

output "key_verions" {
  value = data.azurerm_key_vault_key.encryption_key.version
}

output "key_id" {
  value = data.azurerm_key_vault_key.encryption_key.id
}

output "kv_id" {
  value = data.azurerm_key_vault.key_vault.id
}
