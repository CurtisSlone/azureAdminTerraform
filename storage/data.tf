data "azurerm_storage_account_sas" "storage_account_sas" {
    connection_string = azurerm_storage_account.storage_account.primary_connection_string
    https_only = true
    signed_version = "2017-07-29"

    resource_types {
      service = true
      container = true
      object = true
    }

    services {
      blob = true
      queue = false
      table = false
      file = false
    }

    start = "2024-09-05"
    expiry = "2023-10-05"

    permissions {
      read = true
      write = true
      delete = false
      list = false
      add = true
      create = true
      update = false
      process = false
      tag = false
      filter = false
    }
}

data "azuread_client_config" "current_client" {}