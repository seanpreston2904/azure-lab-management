resource "azurerm_resource_group" "rg_management_networking_aue" {
    name        = "rg-management-common-aue"
    location    = "Australia east"
}

resource "azurerm_virtual_network" "vnet_management_common_aue"{
    name                = "vnet-management-common-aue"
    address_space       = ["10.0.0.0/24"]
    location            = azurerm_resource_group.rg_management_networking_aue.location
    resource_group_name = azurerm_resource_group.rg_management_networking_aue.name
}

resource "azurerm_subnet" "sub_management_terraform_aue" {
    name = "sub-management-terraform-aue"
    
    resource_group_name = azurerm_resource_group.rg_management_networking_aue.name
    virtual_network_name = azurerm_virtual_network.vnet_management_common_aue.name
    
    address_prefixes = ["10.0.0.0/26"]
    service_endpoints = [ "Microsoft.Storage" ]
}