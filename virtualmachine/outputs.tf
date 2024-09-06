output "key_vault_url" {
    value = data.azurerm_key_vault.key_vault.vault_uri
}

output "key_resource_id" {
  value = data.azurerm_key_vault_key.encryption_key.resource_id
}

output "name" {
  value = data.azurerm_key_vault_key.encryption_key.public_key_pem
}