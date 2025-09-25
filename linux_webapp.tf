resource "azurerm_resource_group" "rg" {
 name     = "${var.project_name}-rg"
 location = var.location
}

resource "azurerm_service_plan" "plan" {
 name                = "${var.project_name}-plan"
 location            = azurerm_resource_group.rg.location
 resource_group_name = azurerm_resource_group.rg.name

 os_type = "Linux"
 sku_name = var.plan_sku_name
}

resource "azurerm_linux_web_app" "app" {
 name                = "${var.project_name}-app"
 location            = azurerm_resource_group.rg.location
 resource_group_name = azurerm_resource_group.rg.name
 service_plan_id     = azurerm_service_plan.plan.id
 https_only = true

 site_config {
   # Pick your runtime:
   application_stack {
     # Example for Node
     node_version = "20-lts"

     # Or Python:
     # python_version = "3.12"
     #
     # Or .NET:
     # dotnet_version = "8.0"
   }

   always_on = true
 }

 app_settings = {
   WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
   SCM_DO_BUILD_DURING_DEPLOYMENT      = "true"
 }
}

resource "azurerm_resource_group" "canada_rg" {
  name     = "wa-canada-rg-2"
  location = "Canada Central"

  tags = {
    environment = "dev"
    project     = "wa-canada-2"
  }
}

resource "azurerm_service_plan" "canada_linux_plan" {
  name                = "wa-canada-linux-plan-2"
  location            = azurerm_resource_group.canada_rg.location
  resource_group_name = azurerm_resource_group.canada_rg.name
  os_type             = "Linux"
  sku_name            = "B1"

  tags = {
    environment = "dev"
    project     = "wa-canada-2"
  }
}

locals {
  canada_map_simple = {
    for item in var.canada_items : item => item
  }
}

resource "azurerm_linux_web_app" "canada_apps_simple" {
  for_each            = local.canada_map_simple
  name                = "wa-canada-${each.value}"
  location            = azurerm_service_plan.canada_linux_plan.location
  resource_group_name = azurerm_resource_group.canada_rg.name
  service_plan_id     = azurerm_service_plan.canada_linux_plan.id

  site_config {
    always_on = false
  }

  app_settings = {
    COUNTRY = "canada"
    ITEM    = each.value
  }

  tags = {
    environment = "dev"
    project     = "wa-canada-2"
    item        = each.value
  }
}

output "canada_app_names" {
  value = [for app in azurerm_linux_web_app.canada_apps_simple : app.name]
}

