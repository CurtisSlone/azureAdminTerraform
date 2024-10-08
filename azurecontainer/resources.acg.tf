resource "azurerm_container_group" "container_group" {
    name = "containerGroup"
    location = module.resource_group.rg_location
    resource_group_name = module.resource_group.rg_name
    ip_address_type = "Public"
    dns_name_label = "aci-label"
    os_type = "Linux"

    container {
      name = "hello-world"
     image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
    }
}