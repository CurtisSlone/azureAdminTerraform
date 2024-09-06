provider "azurerm" {
    features {}
}

module "resource_group" {
    source = "../modules/resourcegroups"
    rg_name = var.rg_name
    rg_location = var.rg_location
    default_tags = var.default_tags
}