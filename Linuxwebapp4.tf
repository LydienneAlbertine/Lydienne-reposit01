resource "azurerm_resource_group" "rg4" {
 name     = "${var.project_app4}-rg4"
 location = var.location4
}

resource "azurerm_service_plan" "plan4" {
 name                = "${var.project_app4}-plan4"
 location            = azurerm_resource_group.rg4.location
 resource_group_name = azurerm_resource_group.rg4.name

 os_type = "Linux"
 sku_name = var.plan4_sku_app4
}

resource "azurerm_linux_web_app" "app4" {
 name                = "${var.project_app4}-app4"
 location            = azurerm_resource_group.rg4.location
 resource_group_name = azurerm_resource_group.rg4.name
 service_plan_id     = azurerm_service_plan.plan4.id

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

