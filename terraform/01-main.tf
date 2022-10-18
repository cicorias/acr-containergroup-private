resource "azurerm_resource_group" "this" {
  name     = local.rg_name
  location = var.location
}

# resource "azurerm_resource_group" "ssu_group" {
#   provider = azurerm.ssu-1
#   name     = format("%s-%s", "ssu", var.resource_group_name)
#   location = var.location
# }


locals {
  rg_name = format("%s-%s", var.resource_group_name, var.nonce)
}