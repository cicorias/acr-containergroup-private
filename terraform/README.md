# Issues

```
https://learn.microsoft.com/en-us/azure/container-instances/container-instances-vnet
Private IP address is only supported when network profile is defined.
│ Error: creating Container Group (Subscription: "94b0cff0-edee-4f6f-96dc-03ec2eecfc35"
│ Resource Group Name: "spc-private-b3addcb7"
│ Container Group Name: "spc-aci"): performing ContainerGroupsCreateOrUpdate: containerinstance.ContainerInstanceClient#ContainerGroupsCreateOrUpdate: Failure sending request: StatusCode=0 -- Original Error: Code="PrivateIPAddressNotSupported" Message="IP Address type in container group 'spc-aci' is invalid. Private IP address is only supported when network profile is defined."
│ 
│   with azurerm_container_group.this,
│   on 55-container-group.tf line 1, in resource "azurerm_container_group" "this":
│    1: resource "azurerm_container_group" "this" {
```


# These are the docs...



```
terraform-docs markdown --output-file README.md --output-mode inject .
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.26.0 |
| <a name="provider_azurerm.ssu-1"></a> [azurerm.ssu-1](#provider\_azurerm.ssu-1) | 3.26.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_bastion_host.bastion_host](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/bastion_host) | resource |
| [azurerm_container_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/container_group) | resource |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/container_registry) | resource |
| [azurerm_network_interface.jumpbox_nic](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/network_interface) | resource |
| [azurerm_network_profile.aci](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/network_profile) | resource |
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.ssu_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/resource_group) | resource |
| [azurerm_subnet.aci](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/subnet) | resource |
| [azurerm_subnet.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/subnet) | resource |
| [azurerm_subnet.jumpbox](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/subnet) | resource |
| [azurerm_subnet.subnet-1](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/subnet) | resource |
| [azurerm_subnet.subnet-2](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/subnet) | resource |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_virtual_machine.jumpbox_vm](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/virtual_machine) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.26.0/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_admin_enabled"></a> [acr\_admin\_enabled](#input\_acr\_admin\_enabled) | Enable admin user | `bool` | `false` | no |
| <a name="input_acr_sku"></a> [acr\_sku](#input\_acr\_sku) | The SKU of the container registry | `string` | `"Premium"` | no |
| <a name="input_bastion_name"></a> [bastion\_name](#input\_bastion\_name) | The name of the bastion | `string` | `"spc-bastion"` | no |
| <a name="input_bastion_public_ip_name"></a> [bastion\_public\_ip\_name](#input\_bastion\_public\_ip\_name) | The name of the public IP address for the bastion host | `string` | `"spc-bastion-pip"` | no |
| <a name="input_jumpbox_admin_name"></a> [jumpbox\_admin\_name](#input\_jumpbox\_admin\_name) | The name of the admin user for the jumpbox | `string` | `"azureuser"` | no |
| <a name="input_jumpbox_name"></a> [jumpbox\_name](#input\_jumpbox\_name) | The name of the jumpbox | `string` | `"spc-jumpbox"` | no |
| <a name="input_jumpbox_size"></a> [jumpbox\_size](#input\_jumpbox\_size) | The size of the jumpbox | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region in which all resources in this example should be created. | `string` | `"eastus2"` | no |
| <a name="input_nonce"></a> [nonce](#input\_nonce) | n/a | `string` | `"b3addcb7"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the resources. | `string` | `"spc-private"` | no |
| <a name="input_ssh_key_file"></a> [ssh\_key\_file](#input\_ssh\_key\_file) | The path to the SSH key file | `string` | `"~/.ssh/id_rsa"` | no |
| <a name="input_ssu_1_subscription_id"></a> [ssu\_1\_subscription\_id](#input\_ssu\_1\_subscription\_id) | Subscription id where SSU-1 is located | `string` | `""` | no |
| <a name="input_ssu_1_tenant_id"></a> [ssu\_1\_tenant\_id](#input\_ssu\_1\_tenant\_id) | Tenant id for subscription where SSU-1 is located | `string` | `""` | no |
| <a name="input_subnet_prefix"></a> [subnet\_prefix](#input\_subnet\_prefix) | The subnet prefix | `string` | `"spc"` | no |
| <a name="input_vnet_cidr"></a> [vnet\_cidr](#input\_vnet\_cidr) | The CIDR block of the virtual network | `list(string)` | <pre>[<br>  "172.20.1.0/24"<br>]</pre> | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | The name of the virtual network | `string` | `"spc-vnet"` | no |
| <a name="input_vnet_subnet_cidr"></a> [vnet\_subnet\_cidr](#input\_vnet\_subnet\_cidr) | cidr block for the subnets | `map(any)` | <pre>{<br>  "1": "172.20.1.0/27",<br>  "2": "172.20.1.32/27",<br>  "aci": "172.20.1.64/27",<br>  "bastion": "172.20.1.128/27",<br>  "jumpbox": "172.20.1.96/27"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->


## End of Docsls -ss