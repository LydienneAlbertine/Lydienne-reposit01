resource "azurerm_resource_group" "rg2" {
 name     = "${var.project_app1}-rg2"
 location = var.location2
}

resource "azurerm_service_plan" "plan2" {
 name                = "${var.project_app2}-plan2"
 location            = azurerm_resource_group.rg1.location
 resource_group_name = azurerm_resource_group.rg1.name

 os_type = "Linux"
 sku_name = var.plan2_sku_app2
}

resource "azurerm_linux_web_app" "app2" {
 name                = "${var.project_app1}-app2"
 location            = azurerm_resource_group.rg2.location
 resource_group_name = azurerm_resource_group.rg2.name
 service_plan_id     = azurerm_service_plan.plan2.id

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


