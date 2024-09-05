resource "azurerm_network_interface" "win_vm_nic" {
    name = var.win_vm_nic_name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
        name = var.subnet_name
        subnet_id = azurerm_subnet.vm_subnet.id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_windows_virtual_machine" "win_vm" {
    name = var.win_vm_name
    resource_group_name = azurerm_resource_group.rg.name
    location = var.rg_location
    size = "Standard_F2"

    admin_username = var.win_vm_username
    admin_password = var.win_vm_password
    patch_mode = "AutomaticByPlatform"

    network_interface_ids = [
        azurerm_network_interface.win_vm_nic.id
    ]

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
}