provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=1.44.0"

  subscription_id = "44f3e999-d66c-46c5-bf57-51a749211f95"
  tenant_id       = "3819e9e0-edee-4550-87d3-8303c8222820"
  client_id       = "46aa31ec-1c3d-41c0-9347-e0125225146d"
  client_secret   = "da4067ab-d584-465b-8bbb-b77dceb0e3ee"
}

resource "azurerm_resource_group" "nsgs" {
   name         = "NSGs"
   location     = var.loc
   tags         = var.tags
}

resource "azurerm_network_security_group" "resource_group_default" {
   name = "ResourceGroupDefault"
   resource_group_name  =  azurerm_resource_group.nsgs.name
   location             =  azurerm_resource_group.nsgs.location
   tags                 =  azurerm_resource_group.nsgs.tags
}

resource "azurerm_network_security_rule" "AllowSSH" {
    name = "AllowSSH"
    resource_group_name         = azurerm_resource_group.nsgs.name
    network_security_group_name = azurerm_network_security_group.resource_group_default.name

    priority                    = 1010
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    destination_port_range      = 22
    destination_address_prefix  = "*"
    source_port_range           = "*"
    source_address_prefix       = "*"
}

resource "azurerm_network_security_rule" "AllowHTTP" {
    name = "AllowHTTP"
    resource_group_name         = azurerm_resource_group.nsgs.name
    network_security_group_name = azurerm_network_security_group.resource_group_default.name

    priority                    = 1020
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    destination_port_range      = 80
    destination_address_prefix  = "*"
    source_port_range           = "*"
    source_address_prefix       = "*"
}


resource "azurerm_network_security_rule" "AllowHTTPS" {
    name = "AllowHTTPS"
    resource_group_name         = azurerm_resource_group.nsgs.name
    network_security_group_name = azurerm_network_security_group.resource_group_default.name

    priority                    = 1021
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    destination_port_range      = 443
    destination_address_prefix  = "*"
    source_port_range           = "*"
    source_address_prefix       = "*"
}

resource "azurerm_network_security_rule" "AllowSQLServer" {
    name = "AllowSQLServer"
    resource_group_name         = azurerm_resource_group.nsgs.name
    network_security_group_name = azurerm_network_security_group.resource_group_default.name

    priority                    = 1030
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    destination_port_range      = 1443
    destination_address_prefix  = "*"
    source_port_range           = "*"
    source_address_prefix       = "*"
}

resource "azurerm_network_security_group" "nic_ubuntu" {
   name = "NIC_Ubuntu"
   resource_group_name  = azurerm_resource_group.nsgs.name
   location             = azurerm_resource_group.nsgs.location
   tags                 = azurerm_resource_group.nsgs.tags

    security_rule {
        name                       = "SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = 22
        source_address_prefix      = "*"
        destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "nic_window" {
   name = "NIC_Window"
   resource_group_name  = azurerm_resource_group.nsgs.name
   location             = azurerm_resource_group.nsgs.location
   tags                 = azurerm_resource_group.nsgs.tags

    security_rule {
        name                       = "RDP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = 3389
        source_address_prefix      = "*"
        destination_address_prefix = "*"
  }
}
