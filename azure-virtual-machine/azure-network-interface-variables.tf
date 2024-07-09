#
# Azure Network Interfaces
#

locals {
  #
  # Azure Network Interfaces
  #
  azure_network_interface = flatten([
    for interface_id, interface in coalesce(try(var.vm.network_interface, null), {}) : merge(
      interface,
      {
        resource_index = join("_", [interface_id])
      }
    )
  ])
}
