resource "azurerm_virtual_network" "vm_vnet" {
  name = var.vnet_name
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "vm_subnet" {
  name = var.subnet_name
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vm_vnet.name
  address_prefixes = ["10.0.2.0/24"]

}

