resource "azurerm_resource_group" "rg7" {
 name     = "${var.project_app7}-rg7"
 location = var.location7
}

resource "azurerm_service_plan" "plan7" {
 name                = "${var.project_app7}-plan7"
 location            = azurerm_resource_group.rg7.location
 resource_group_name = azurerm_resource_group.rg7.name

 os_type = "Linux"
 sku_name = var.plan7_sku_app7
}

resource "azurerm_windows_web_app" "app7" {
 name                = "${var.project_app7}-app7"
 location            = azurerm_resource_group.rg7.location
 resource_group_name = azurerm_resource_group.rg7.name
 service_plan_id     = azurerm_service_plan.plan7.id

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
variable "webapp_app7" {
  type    = list(string)
  default = ["app1", "app2", "app3", "app4", "app5"]
}

resource "azurerm_windows_resource_group" "mcitazurerm7" {
  name     = "septemberazurerm"
  location = "Canada Central"
}

resource "azurerm_service_plan" "mcitsplan7" {
  name                = "mcitserviceplan"
  resource_group_name = azurerm_resource_group.mcitazurerm.name
  location            = azurerm_resource_group.mcitazurerm.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

