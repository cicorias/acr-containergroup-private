variable "nonce" {
  type    = string
  default = "b3addcb7"
}

variable "ssu_1_subscription_id" {
  type        = string
  default     = ""
  description = "Subscription id where SSU-1 is located"
}

variable "ssu_1_tenant_id" {
  type        = string
  default     = ""
  description = "Tenant id for subscription where SSU-1 is located"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the resources."
  default     = "spc-private"
}

variable "location" {
  type        = string
  description = "The Azure Region in which all resources in this example should be created."
  default     = "eastus2"
}

# variable "dns_prefix" {
#   type        = string
#   description = "The DNS prefix for the public IP address."
#   default     = "spc-"
# }


# locals {
#   resource_group_name = "acr-private"
#   location            = "eastus2"
#   dns_prefix          = "spc-"

#   acr_name          = "acrprivate"
#   acr_sku           = "Premium"
#   acr_admin_enabled = false

# }

### ACR settings

# variable "acr_name" {
#   type        = string
#   description = "The name of the Azure Container Registry."
#   default     = local.acr_name
# }

variable "acr_sku" {
  description = "The SKU of the container registry"
  type        = string
  default     = "Premium"
}

variable "acr_admin_enabled" {
  description = "Enable admin user"
  type        = bool
  default     = false
}


## vnet settings

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "spc-vnet"
}

variable "subnet_prefix" {
  description = "The subnet prefix"
  type        = string
  default     = "spc"
}

variable "vnet_cidr" {
  description = "The CIDR block of the virtual network"
  type        = list(string)
  default     = ["172.20.1.0/24"]
}

variable "vnet_subnet_cidr" {
  description = "cidr block for the subnets"
  type        = map(any)
  default = {
    1       = "172.20.1.0/27"
    2       = "172.20.1.32/27"
    aci     = "172.20.1.64/27"
    jumpbox = "172.20.1.96/27"
    bastion = "172.20.1.128/27"
  }
}


## bastion


variable "bastion_name" {
  description = "The name of the bastion"
  type        = string
  default     = "spc-bastion"
}

variable "bastion_public_ip_name" {
  description = "The name of the public IP address for the bastion host"
  type        = string
  default     = "spc-bastion-pip"
}

variable "jumpbox_name" {
  description = "The name of the jumpbox"
  type        = string
  default     = "spc-jumpbox"
}

variable "jumpbox_size" {
  description = "The size of the jumpbox"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "jumpbox_admin_name" {
  description = "The name of the admin user for the jumpbox"
  type        = string
  default     = "azureuser"
}

variable "ssh_key_file" {
  description = "The path to the SSH key file"
  type        = string
  default     = "~/.ssh/id_rsa"
}
