#
# Azure Public IPs
#

variable "public_ip" {
  type = map(object({
    name                    = string
    resource_group_name     = string
    location                = string
    allocation_method       = string
    zones                   = optional(list(string))
    ddos_protection_mode    = optional(string)
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags                 = optional(map(string))
    ip_version              = optional(string)
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    sku                     = optional(string)
    sku_tier                = optional(string)
    tags                    = optional(map(string))
  }))
  default = {}
}

locals {
  #
  # Azure Public IPs
  #
  azure_public_ip = flatten([
    for ip_id, ip in coalesce(try(var.public_ip, null), {}) : merge(
      ip,
      {
        resource_index = join("_", [ip_id])
      }
    )
  ])
}
