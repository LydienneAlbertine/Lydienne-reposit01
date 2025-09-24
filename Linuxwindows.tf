# Groupe de ressources
resource "azurerm_resource_group" "mcitazurerm" {
  name     = "septemberazurerm"
  location = "Canada Central"
}

# Service Plan (partagé entre toutes les apps)
resource "azurerm_service_plan" "mcitsplanok" {
  name                = "mcitserviceplan"
  resource_group_name = azurerm_resource_group.mcitazurerm.name
  location            = azurerm_resource_group.mcitazurerm.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}
# Création des 10 Web Apps avec count
resource "azurerm_linux_web_app" "mcitwebapps" {
  count               = length(var.webapp_names)
  name                = var.webapp_names[count.index]
  location            = azurerm_resource_group.mcitazurerm.location
  resource_group_name = azurerm_resource_group.mcitazurerm.name
  service_plan_id     = azurerm_service_plan.mcitsplanok.id

  site_config {
    application_stack {
      node_version = "18-lts"
    }
  }
}

# Sortie : noms des web apps créées
output "webapp_names" {
  value = azurerm_linux_web_app.mcitwebapps[*].name
}

