resource "azurerm_virtual_network" "vm_vnet" {
  name = var.vnet_name
  address_space = ["10.0.0.0/16"]
  location = data.azurerm_resource_group.current_rg.location
  resource_group_name = data.azurerm_resource_group.current_rg.name
}

resource "azurerm_subnet" "vm_subnet" {
  name = var.subnet_name
    resource_group_name = data.azurerm_resource_group.current_rg.name
  virtual_network_name = azurerm_virtual_network.vm_vnet.name
  address_prefixes = ["10.0.2.0/24"]

  depends_on = [ 
    azurerm_virtual_network.vm_vnet
   ]
}

resource "azurerm_network_security_group" "nsg" {
  name = "${var.vnet_name}_nsg"
  location = data.azurerm_resource_group.current_rg.location
    resource_group_name = data.azurerm_resource_group.current_rg.name

  security_rule {
    name = "AllowRDP"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "3389"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

