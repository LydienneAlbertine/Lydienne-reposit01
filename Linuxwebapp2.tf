resource "azurerm_linux_web_app" "apps" {
  for_each            = toset(var.webapps)

  name                = "${var.project_app2}-${each.key}"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  service_plan_id     = azurerm_service_plan.plan2.id

  https_only = true

  site_config {
    application_stack {
      node_version = "20-lts"
      # ou python_version / dotnet_version selon ton besoin
    }

    always_on = true
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    SCM_DO_BUILD_DURING_DEPLOYMENT      = "true"
  }
}
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


