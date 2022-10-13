## BASTION HOST RESOURCES

resource "azurerm_public_ip" "public_ip" {
  name                = var.bastion_public_ip_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion_host" {
  name                = var.bastion_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"
  ip_connect_enabled  = true
  tunneling_enabled   = true

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

## JUMP BOX INFRA HERE

resource "azurerm_network_interface" "jumpbox_nic" {
  name                 = "${var.jumpbox_name}-nic"
  location             = azurerm_resource_group.this.location
  resource_group_name  = azurerm_resource_group.this.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "${var.jumpbox_name}-configuration"
    subnet_id                     = azurerm_subnet.jumpbox.id
    private_ip_address_allocation = "Dynamic"
  }
}

# NOTE: this machine will use default outbound access to reach the internet.
# If you cannot reach the internet, your network or VMs might have that option disabled.

locals {
  custom_data = <<CUSTOM_DATA
#!/bin/bashsudo 
apt update
apt install -y curl net-tools
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
mv kubectl /usr/local/bin/
chmod +x /usr/local/bin/kubectl
  CUSTOM_DATA
}

resource "azurerm_virtual_machine" "jumpbox_vm" {
  name                  = var.jumpbox_name
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
  network_interface_ids = [azurerm_network_interface.jumpbox_nic.id]
  vm_size               = var.jumpbox_size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.jumpbox_name}-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.jumpbox_name
    admin_username = var.jumpbox_admin_name
    custom_data    = base64encode(local.custom_data)
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("${var.ssh_key_file}.pub")
      path     = "/home/${var.jumpbox_admin_name}/.ssh/authorized_keys"
    }
  }
}
