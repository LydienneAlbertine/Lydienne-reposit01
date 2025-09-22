resource "azurerm_resource_group" "rg1" {
 name     = "${var.project_app1}-rg1"
 location = var.location1
}

resource "azurerm_service_plan" "plan1" {
 name                = "${var.project_app1}-plan1"
 location            = azurerm_resource_group.rg1.location
 resource_group_name = azurerm_resource_group.rg1.name

 os_type = "Linux"
 sku_name = var.plan1_sku_app1
}

resource "azurerm_linux_web_app" "app1" {
 name                = "${var.project_app1}-app1"
 location            = azurerm_resource_group.rg1.location
 resource_group_name = azurerm_resource_group.rg1.name
 service_plan_id     = azurerm_service_plan.plan1.id

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

