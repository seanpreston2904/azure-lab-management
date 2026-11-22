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

resource "azurerm_virtual_network_peering" "management_to_hub" {
    name                         = "peer-management-to-hub"
    resource_group_name          = azurerm_resource_group.rg_management_networking_aue.name
    virtual_network_name         = azurerm_virtual_network.vnet_management_common_aue.name
    remote_virtual_network_id    = "/subscriptions/8a801d80-d2e2-4b75-8c85-777576ae7408/resourceGroups/rg-connectivity-hub-aue/providers/Microsoft.Network/virtualNetworks/vnet-connectivity-hub-aue"
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
}