resource "azurerm_resource_group" "rg_tg_state_aue" {
    name        = "rg-tf-state-aue"
    location    = "Australia East"
}

resource "azurerm_storage_account" "stspdevtfstate" {
    name                            = "stspdevtfstate"
    resource_group_name             = azurerm_resource_group.rg_tg_state_aue.name

    location                        = azurerm_resource_group.rg_tg_state_aue.location
    account_tier                    = "Standard"
    account_replication_type        = "LRS"

    public_network_access_enabled   = true
    shared_access_key_enabled       = false

    network_rules {
        default_action              = "Allow"
        virtual_network_subnet_ids  = ["/subscriptions/6f1637b0-e4cc-4ee8-8574-eb9dc6845692/resourceGroups/rg-management-common-aue/providers/Microsoft.Network/virtualNetworks/vnet-management-common-aue/subnets/sub-management-terraform-aue"]
        ip_rules                    = []
        bypass = ["AzureServices"]
    }
}