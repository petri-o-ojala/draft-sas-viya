<!-- BEGIN_TF_DOCS -->

Azure Roles

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_federated_identity_credential.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_marketplace_role_assignment.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/marketplace_role_assignment) | resource |
| [azurerm_pim_active_role_assignment.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/pim_active_role_assignment) | resource |
| [azurerm_pim_eligible_role_assignment.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/pim_eligible_role_assignment) | resource |
| [azurerm_role_assignment.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.user_assigned_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_user_assigned_identity.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_role_definition.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common"></a> [common](#input\_common) | Common Azure resource parameters | <pre>object({<br>    tags            = optional(map(string))<br>    custom_metadata = optional(map(string))<br>  })</pre> | `{}` | no |
| <a name="input_entra_id"></a> [entra\_id](#input\_entra\_id) | Entra ID configuration | <pre>object({<br>    alias = optional(map(string), {})<br>  })</pre> | <pre>{<br>  "alias": {}<br>}</pre> | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Azure Identities | <pre>object({<br>    user_assigned = optional(map(object({<br>      name                = string<br>      location            = string<br>      resource_group_name = string<br>      tags                = optional(map(string))<br>      federated_credential = optional(list(object({<br>        name                = string<br>        resource_group_name = optional(string)<br>        audience            = list(string)<br>        issuer              = string<br>        parent_id           = optional(string)<br>        subject             = string<br>      })))<br>      iam = optional(list(object({<br>        name                                   = optional(string)<br>        role_definition_name                   = optional(string)<br>        role_definition_id                     = optional(string)<br>        principal_type                         = optional(string)<br>        scope                                  = optional(string)<br>        condition                              = optional(string)<br>        condition_version                      = optional(string)<br>        delegated_managed_identity_resource_id = optional(string)<br>        description                            = optional(string)<br>        skip_service_principal_aad_check       = optional(bool)<br>      })))<br>    })))<br>  })</pre> | `{}` | no |
| <a name="input_pim"></a> [pim](#input\_pim) | Azure PIM | <pre>object({<br>    active_role_assignment = optional(map(object({<br>      principal_id       = string<br>      role_definition_id = string<br>      scope              = string<br>      justification      = optional(string)<br>      schedule = optional(object({<br>        start_date_time = optional(string)<br>        expiration = optional(object({<br>          duration_days  = optional(string)<br>          duration_hours = optional(string)<br>          end_date_time  = optional(string)<br>        }))<br>      }))<br>      ticket = optional(object({<br>        number = optional(string)<br>        system = optional(string)<br>      }))<br>    })))<br>    eligible_role_assignment = optional(map(object({<br>      principal_id       = string<br>      role_definition_id = string<br>      scope              = string<br>      justification      = optional(string)<br>      schedule = optional(object({<br>        start_date_time = optional(string)<br>        expiration = optional(object({<br>          duration_days  = optional(string)<br>          duration_hours = optional(string)<br>          end_date_time  = optional(string)<br>        }))<br>      }))<br>      ticket = optional(object({<br>        number = optional(string)<br>        system = optional(string)<br>      }))<br>    })))<br>  })</pre> | `{}` | no |
| <a name="input_reference"></a> [reference](#input\_reference) | Azure Resource references | <pre>object({<br>    azure_resource_group = optional(map(any))<br>  })</pre> | `{}` | no |
| <a name="input_role"></a> [role](#input\_role) | Azure Roles | <pre>object({<br>    definition = optional(map(object({<br>      name                = string<br>      scope               = string<br>      description         = optional(string)<br>      assignable_scopes   = optional(list(string))<br>      role_definition_id  = optional(string)<br>      predefined_role     = optional(list(string))<br>      exclude_permissions = optional(list(string))<br>      permissions = optional(object({<br>        actions          = optional(list(string))<br>        data_actions     = optional(list(string))<br>        not_actions      = optional(list(string))<br>        not_data_actions = optional(list(string))<br>      }))<br>    })))<br>    assignment = optional(map(object({<br>      name                                   = optional(string)<br>      principal_id                           = string<br>      scope                                  = string<br>      role_definition_id                     = optional(string)<br>      role_definition_name                   = optional(string)<br>      role_definition_names                  = optional(list(string))<br>      principal_type                         = optional(string)<br>      condition                              = optional(string)<br>      condition_version                      = optional(string)<br>      delegated_managed_identity_resource_id = optional(string)<br>      description                            = optional(string)<br>      skip_service_principal_aad_check       = optional(bool)<br>    })))<br>    marketplace_assignment = optional(map(object({<br>    })))<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_federated_identity_credential"></a> [azure\_federated\_identity\_credential](#output\_azure\_federated\_identity\_credential) | Azure Federated Identity Credentials |
| <a name="output_azure_role_definition"></a> [azure\_role\_definition](#output\_azure\_role\_definition) | Azure Role Definitions |
| <a name="output_azure_user_assigned_identity"></a> [azure\_user\_assigned\_identity](#output\_azure\_user\_assigned\_identity) | Azure User Assigned Identities |
<!-- END_TF_DOCS -->