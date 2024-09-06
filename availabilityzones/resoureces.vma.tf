resource "azurerm_network_interface" "vma_nic" {
  name = "vma_nic"
  location = module.resource_group.rg_location
  resource_group_name = module.resource_group.rg_name

  ip_configuration {
    name = "${var.subnet_name}_vma"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vma" {
  name = "VMA"
  location = module.resource_group.rg_location
  resource_group_name = module.resource_group.rg_name
  size = "Standard_F2"
  admin_username = "admin"
  admin_password = "P@$$w0rd!"
  patch_mode = "AutomaticByPlatform"
  availability_set_id = azurerm_availability_set.availability_set.id

  network_interface_ids = [ azurerm_network_interface.vma_nic.id ]

  os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2016-Datacenter"
        version = "latest"
    }
    depends_on = [ azurerm_network_interface.vma_nic ]

}