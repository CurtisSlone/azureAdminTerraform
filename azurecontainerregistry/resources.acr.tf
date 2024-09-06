resource "azurerm_container_registry" "acr" {
  name = "binsparkACR"
  resource_group_name = module.resource_group.rg_name
  location = module.resource_group.rg_location
  sku = "Premium"
    admin_enabled = true
  
  georeplications {
    location = "North Europe"
    zone_redundancy_enabled = true
  }

  public_network_access_enabled = true
}