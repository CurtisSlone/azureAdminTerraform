resource "azurerm_role_assignment" "admin_login_role" {
    scope = azurerm_windows_virtual_machine.win_vm.id
    role_definition_name = "Virtual Machine Administrator Login"
    principal_id = data.azurerm_client_config.current_client.object_id
}

resource "azurerm_role_assignment" "user_login_role" {
    scope = azurerm_windows_virtual_machine.win_vm.id
    role_definition_name = "Virtual Machine User Login"
    principal_id = data.azurerm_client_config.current_client.object_id
}