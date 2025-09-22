resource "azurerm_resource_group" "rg5" {
 name     = "${var.project_app5}-rg5"
 location = var.location5
}

resource "azurerm_service_plan" "plan5" {
 name                = "${var.project_app5}-plan5"
 location            = azurerm_resource_group.rg5.location
 resource_group_name = azurerm_resource_group.rg5.name

 os_type = "Linux"
 sku_name = var.plan5_sku_app5
}

resource "azurerm_linux_web_app" "app5" {
 name                = "${var.project_app5}-app5"
 location            = azurerm_resource_group.rg5.location
 resource_group_name = azurerm_resource_group.rg5.name
 service_plan_id     = azurerm_service_plan.plan5.id

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

