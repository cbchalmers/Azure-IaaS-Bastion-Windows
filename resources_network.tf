resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.resource_prefix}-BASTION-WIN-vn"
  address_space       = ["172.16.0.0/16"]
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
}

resource "azurerm_subnet" "SUBNET-1" {
  name                 = "SUBNET-1"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["172.16.1.0/24"]
}

resource "azurerm_subnet" "SUBNET-2" {
  name                 = "SUBNET-2"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["172.16.2.0/24"]
}

resource "azurerm_route_table" "route_table" {
  name                          = "${var.resource_prefix}-BASTION-WIN-rt"
  resource_group_name           = azurerm_resource_group.resource_group.name
  location                      = azurerm_resource_group.resource_group.location
  disable_bgp_route_propagation = false

  route {
    name           = "UDR-Internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

resource "azurerm_subnet_route_table_association" "RT-SN1" {
  subnet_id      = azurerm_subnet.SUBNET-1.id
  route_table_id = azurerm_route_table.route_table.id
}

resource "azurerm_subnet_route_table_association" "RT-SN2" {
  subnet_id      = azurerm_subnet.SUBNET-2.id
  route_table_id = azurerm_route_table.route_table.id
}

resource "azurerm_network_security_group" "security_group" {
  name                = "${var.resource_prefix}-BASTION-WIN-ns"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
}

resource "azurerm_network_security_rule" "AllowRemoteLocation" {
  name                        = "AllowRemoteLocation"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.remote_location
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.security_group.name
}

resource "azurerm_subnet_network_security_group_association" "AssignNsgSubnet1" {
  subnet_id                 = azurerm_subnet.SUBNET-1.id
  network_security_group_id = azurerm_network_security_group.security_group.id
}

resource "azurerm_subnet_network_security_group_association" "AssignNsgSubnet2" {
  subnet_id                 = azurerm_subnet.SUBNET-2.id
  network_security_group_id = azurerm_network_security_group.security_group.id
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.resource_prefix}-BASTION-WIN-ip"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  allocation_method   = "Static"
}