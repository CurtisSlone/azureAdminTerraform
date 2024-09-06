resource "azurerm_availability_set" "availability_set"{
  name = "azure_as"
  location = module.resource_group.rg_location
  resource_group_name = module.resource_group.rg_name

    platform_update_domain_count = 3
    platform_fault_domain_count = 5
  tags = var.default_tags
}