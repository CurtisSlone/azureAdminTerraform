resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  address_space = ["10.0.0.0/16"]
  location = module.resource_group.rg_location
  resource_group_name = module.resource_group.rg_name
}

resource "azurerm_subnet" "subnet" {
  name = var.subnet_name
  resource_group_name = module.resource_group.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = ["10.0.2.0/24"]

  depends_on = [ azurerm_virtual_network.vnet ]
}

