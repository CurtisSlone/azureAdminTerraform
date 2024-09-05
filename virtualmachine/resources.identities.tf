resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  name                = "${var.win_vm_name}_uai"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.rg_location
}