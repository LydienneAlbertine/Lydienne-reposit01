resource "azurerm_resource_group" "rg3" {
 name     = "${var.project_app3}-rg3"
 location = var.location3
}
resource "azurerm_service_plan" "plan3" {
 name                = "${var.project_app3}-plan3"
 location            = azurerm_resource_group.rg3.location
 resource_group_name = azurerm_resource_group.rg3.name

 os_type = "Linux"
 sku_name = var.plan3_sku_app3
}

resource "azurerm_linux_web_app" "app3" {
 name                = "${var.project_app3}-app3"
 location            = azurerm_resource_group.rg3.location
 resource_group_name = azurerm_resource_group.rg3.name
 service_plan_id     = azurerm_service_plan.plan3.id

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

