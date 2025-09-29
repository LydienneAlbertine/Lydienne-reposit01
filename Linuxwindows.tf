# Variable avec noms des Web Apps
variable "webapp_names" {
  type = list(string)
  default = ["wa-canada-mapleleaf","wa-canada-hockey","wa-canada-poutine","wa-canada-mountie","wa-canada-niagara","wa-canada-timhortons","wa-canada-beavertail","wa-canada-loonie","wa-canada-canoe","wa-canada-igloo"]
}

# Groupe de ressources
resource "azurerm_resource_group" "mcitazurerm" {
  name     = "septemberazurerm"
  location = "Canada Central"
}
# Service Plan
resource "azurerm_service_plan" "mcitsplanok" {
  name                = "mcitserviceplan"
  resource_group_name = azurerm_resource_group.mcitazurerm.name
  location            = azurerm_resource_group.mcitazurerm.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

# Création des Web Apps avec for_each
resource "azurerm_linux_web_app" "mcitwebapps" {
  for_each            = { for name in var.webapp_names : name => name }
  name                = each.key
  location            = azurerm_resource_group.mcitazurerm.location
  resource_group_name = azurerm_resource_group.mcitazurerm.name
  service_plan_id     = azurerm_service_plan.mcitsplanok.id

  site_config {
    application_stack {
      node_version = "18-lts"
    }
  }
}
# Output : noms des web apps
output "webapp_names" {
  value = azurerm_linux_web_app.mcitwebapps
 sensitive = true
}
