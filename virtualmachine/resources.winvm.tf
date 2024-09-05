resource "azurerm_network_interface" "win_vm_nic" {
    name = var.win_vm_nic_name
    location = var.rg_location
    resource_group_name = azurerm_resource_group.rg.name
    

    ip_configuration {
        name = var.subnet_name
        subnet_id = azurerm_subnet.vm_subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.win_vm_pip.ip_address
    }

    depends_on = [
        azurerm_public_ip.win_vm_pip
     ]
}

resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id = azurerm_network_interface.win_vm_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id

  depends_on = [
    azurerm_network_interface.win_vm_nic,
    azurerm_network_security_group.nsg
   ]
}

resource "azurerm_public_ip" "win_vm_pip" {
  name = "${var.win_vm_name}_pip"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Static"

  tags = {
    environment = "Development"
  }
}

resource "azurerm_windows_virtual_machine" "win_vm" {
    name = var.win_vm_name
    resource_group_name = azurerm_resource_group.rg.name
    location = var.rg_location
    size = "Standard_F2"
    computer_name = "binsparkwinserv"
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

    identity {
      type = "UserAssigned"
      identity_ids = [azurerm_user_assigned_identity.user_assigned_identity.id]
    }

    depends_on = [ 
        azurerm_network_interface.win_vm_nic
     ]
}

# DISK ENCRYPTION
resource "azurerm_virtual_machine_extension" "vm_extension" {
    name = "${var.win_vm_name}_AzDiskEncryption"
    publisher = "Microsoft.Azure.Security"
    type = "AzureDiskEncryption"
    type_handler_version = "2.2"
    auto_upgrade_minor_version = false
    virtual_machine_id = azurerm_windows_virtual_machine.win_vm.id

    settings = <<SETTINGS
    {
        "EncryptionOperation": "EnableEncryption",
        "KeyEncryptionAlgorithm": "RSA-OAEP",
        "KeyVaultURL": "${azurerm_key_vault.vm_kv.vault_uri}",
        "KeyVaultResourceId": "${azurerm_key_vault.vm_kv.id}",
        "KeyEncryptionKeyURL": "${azurerm_key_vault.vm_kv.vault_uri}",
        "KekVaultResourceId": "${azurerm_key_vault.vm_kv.id}",
        "VolumeType": "All"
    }
    SETTINGS
    depends_on = [ 
        azurerm_key_vault.vm_kv,
        azurerm_windows_virtual_machine.win_vm
     ]
}

#ENTRA ID LOGIN
resource "azurerm_virtual_machine_extension" "entraid_login_extension" {
    name = "${var.win_vm_name}_entraid_login"
    virtual_machine_id = azurerm_windows_virtual_machine.win_vm.id
    publisher = "Microsoft.Azure.ActiveDirectory"
    type = "AADLoginForWindows"
    type_handler_version = "1.0"
    auto_upgrade_minor_version = true

    settings = <<SETTINGS
    {}
    SETTINGS

    depends_on = [
        azurerm_windows_virtual_machine.win_vm
    ]
}