locals {
  acr_name = replace(format("%s%s", var.resource_group_name, var.nonce), "-", "")
}

resource "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = var.acr_sku
  admin_enabled       = var.acr_admin_enabled

}
