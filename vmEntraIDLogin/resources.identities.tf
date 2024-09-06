# resource "azurerm_user_assigned_identity" "user_assigned_identity" {
#   name                = "${var.win_vm_name}-uai"
#    location = data.azurerm_resource_group.current_rg.location
#     resource_group_name = data.azurerm_resource_group.current_rg.name
# }