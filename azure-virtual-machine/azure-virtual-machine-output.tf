#
# Terraform module outputs
#

output "azure_windows_virtual_machine" {
  description = "Azure Windows Virtual Machines"
  value       = azurerm_windows_virtual_machine.lz
}

output "azure_public_ip" {
  description = "Azure Public IPs"
  value       = azurerm_public_ip.lz
}
