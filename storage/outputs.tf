output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}

output "sas_url" {
    value = data.azurerm_storage_account_sas.storage_account_sas.sas
    sensitive = true
}

output "storage_container_id"{
    value = azurerm_storage_container.storage_container.id
}

output "azcopy_app_id" {
    value = azuread_application.az_copy_app.application_id
}

output "azcopy_app_secret"{
    value = azuread_application_password.azcopy_app_password.value
    sensitive = true
}

output "azcopy_spn_client_id"{
    value = azuread_service_principal.azcopy_spn.id
}

output "azcopy_spn_client_secret"{
    value = azuread_service_principal_password.azcopy_spn_pass.value
    sensitive = true
}

output "storage_account_url" {
    value = azurerm_storage_account.storage_account.primary_connection_string
    sensitive = true
}