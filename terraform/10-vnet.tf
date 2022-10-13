resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.vnet_cidr
}

resource "azurerm_subnet" "subnet-1" {
  name                 = format("%s-%s", var.subnet_prefix, "1")
  resource_group_name  = azurerm_virtual_network.this.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [lookup(var.vnet_subnet_cidr, "1")]
}

resource "azurerm_subnet" "subnet-2" {
  name                 = format("%s-%s", var.subnet_prefix, "2")
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [lookup(var.vnet_subnet_cidr, "2")]
}

resource "azurerm_subnet" "aci" {
  name                 = format("%s-%s", var.subnet_prefix, "aci")
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [lookup(var.vnet_subnet_cidr, "aci")]

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

}

resource "azurerm_network_profile" "aci" {
  name                = "aci"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  container_network_interface {
    name = "acinic"

    ip_configuration {
      name      = "exampleipconfig"
      subnet_id = azurerm_subnet.aci.id
    }
  }
}

resource "azurerm_subnet" "jumpbox" { // jumpbox subnet
  name                 = format("%s-%s", var.subnet_prefix, "jumpbox")
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [lookup(var.vnet_subnet_cidr, "jumpbox")]
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [lookup(var.vnet_subnet_cidr, "bastion")]
}

# ➜  acr-private git:(cicorias/minorupdates) ✗ ipcalc 172.20.1.0/24 27
# Address:   172.20.1.0           10101100.00010100.00000001. 00000000
# Netmask:   255.255.255.0 = 24   11111111.11111111.11111111. 00000000
# Wildcard:  0.0.0.255            00000000.00000000.00000000. 11111111
# =>
# Network:   172.20.1.0/24        10101100.00010100.00000001. 00000000
# HostMin:   172.20.1.1           10101100.00010100.00000001. 00000001
# HostMax:   172.20.1.254         10101100.00010100.00000001. 11111110
# Broadcast: 172.20.1.255         10101100.00010100.00000001. 11111111
# Hosts/Net: 254                   Class B, Private Internet

# Subnets after transition from /24 to /27

# Netmask:   255.255.255.224 = 27 11111111.11111111.11111111.111 00000
# Wildcard:  0.0.0.31             00000000.00000000.00000000.000 11111

#  1.
# Network:   172.20.1.0/27        10101100.00010100.00000001.000 00000
# HostMin:   172.20.1.1           10101100.00010100.00000001.000 00001
# HostMax:   172.20.1.30          10101100.00010100.00000001.000 11110
# Broadcast: 172.20.1.31          10101100.00010100.00000001.000 11111
# Hosts/Net: 30                    Class B, Private Internet

#  2.
# Network:   172.20.1.32/27       10101100.00010100.00000001.001 00000
# HostMin:   172.20.1.33          10101100.00010100.00000001.001 00001
# HostMax:   172.20.1.62          10101100.00010100.00000001.001 11110
# Broadcast: 172.20.1.63          10101100.00010100.00000001.001 11111
# Hosts/Net: 30                    Class B, Private Internet

#  3.
# Network:   172.20.1.64/27       10101100.00010100.00000001.010 00000
# HostMin:   172.20.1.65          10101100.00010100.00000001.010 00001
# HostMax:   172.20.1.94          10101100.00010100.00000001.010 11110
# Broadcast: 172.20.1.95          10101100.00010100.00000001.010 11111
# Hosts/Net: 30                    Class B, Private Internet

#  4.
# Network:   172.20.1.96/27       10101100.00010100.00000001.011 00000
# HostMin:   172.20.1.97          10101100.00010100.00000001.011 00001
# HostMax:   172.20.1.126         10101100.00010100.00000001.011 11110
# Broadcast: 172.20.1.127         10101100.00010100.00000001.011 11111
# Hosts/Net: 30                    Class B, Private Internet

#  5.
# Network:   172.20.1.128/27      10101100.00010100.00000001.100 00000
# HostMin:   172.20.1.129         10101100.00010100.00000001.100 00001
# HostMax:   172.20.1.158         10101100.00010100.00000001.100 11110
# Broadcast: 172.20.1.159         10101100.00010100.00000001.100 11111
# Hosts/Net: 30                    Class B, Private Internet

#  6.
# Network:   172.20.1.160/27      10101100.00010100.00000001.101 00000
# HostMin:   172.20.1.161         10101100.00010100.00000001.101 00001
# HostMax:   172.20.1.190         10101100.00010100.00000001.101 11110
# Broadcast: 172.20.1.191         10101100.00010100.00000001.101 11111
# Hosts/Net: 30                    Class B, Private Internet

#  7.
# Network:   172.20.1.192/27      10101100.00010100.00000001.110 00000
# HostMin:   172.20.1.193         10101100.00010100.00000001.110 00001
# HostMax:   172.20.1.222         10101100.00010100.00000001.110 11110
# Broadcast: 172.20.1.223         10101100.00010100.00000001.110 11111
# Hosts/Net: 30                    Class B, Private Internet

#  8.
# Network:   172.20.1.224/27      10101100.00010100.00000001.111 00000
# HostMin:   172.20.1.225         10101100.00010100.00000001.111 00001
# HostMax:   172.20.1.254         10101100.00010100.00000001.111 11110
# Broadcast: 172.20.1.255         10101100.00010100.00000001.111 11111
# Hosts/Net: 30                    Class B, Private Internet


# Subnets:   8
# Hosts:     240