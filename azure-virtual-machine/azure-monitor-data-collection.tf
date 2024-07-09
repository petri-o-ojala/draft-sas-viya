#
# Aure Monitor Data Collection Rules
#

data "azurerm_monitor_data_collection_rule" "lz" {
  for_each = {
    for dc_rule in local.azure_data_collection_rule : dc_rule.resource_index => dc_rule
  }

  name                = each.value.data_collection_rule
  resource_group_name = each.value.data_collection_rule_resource_group_name
}

resource "azurerm_monitor_data_collection_rule_association" "lz" {
  for_each = {
    for dc_rule in local.azure_data_collection_rule_association : dc_rule.resource_index => dc_rule
  }

  name        = each.value.name
  description = each.value.description

  target_resource_id      = each.value.target_resource_id
  data_collection_rule_id = each.value.data_collection_rule_id
}
