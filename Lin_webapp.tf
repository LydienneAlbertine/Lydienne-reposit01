# Variables
# =========================================
variable "apps_with_region" {
  type = map(object({
    app_name     : string
    sku_name     : string
    worker_count : number
  }))
  default = {
    "Canada Central" = { app_name = "inovocb-api-win-cc",  sku_name = "B1",   worker_count = 1 }
    "East US"        = { app_name = "riidoz-ui-win-eus",   sku_name = "S1",   worker_count = 2 }
    "West Europe"    = { app_name = "gamecb-core-win-weu", sku_name = "P1v3", worker_count = 2 }
    "Australia East" = { app_name = "analytics-win-aue",   sku_name = "P2v3", worker_count = 3 }
  }
}

# =========================================
# Resource Groups
# =========================================
resource "azurerm_resource_group" "mcitrglyd" {
  for_each = var.apps_with_region

  name     = "mcitrglyd-${replace(lower(each.key), " ", "-")}"
  location = each.key
}

# =========================================
# Linux App Service Plans
# =========================================
resource "azurerm_service_plan" "planol" {
  for_each            = var.apps_with_region
  name                = "asp-${replace(lower(each.key), " ", "-")}"
  location            = azurerm_resource_group.mcitrglyd[each.key].location
  resource_group_name = azurerm_resource_group.mcitrglyd[each.key].name

  os_type      = "Linux"
  sku_name     = each.value.sku_name
  worker_count = each.value.worker_count
}

# =========================================
# Linux Web Apps
# =========================================
resource "azurerm_linux_web_app" "applydi" {
  for_each            = var.apps_with_region
  name                = each.value.app_name        # doit être globalement unique
  location            = azurerm_resource_group.mcitrglyd[each.key].location
  resource_group_name = azurerm_resource_group.mcitrglyd[each.key].name
  service_plan_id     = azurerm_service_plan.planol[each.key].id
  https_only          = true

  site_config {
    always_on           = true
    minimum_tls_version = "1.2"
    ftps_state          = "FtpsOnly"
    linux_fx_version    = "NODE|18-lts"  # runtime Node.js 18
  }

  app_settings = {
    ENVIRONMENT = "prod"
    REGION_NAME = each.key
  }
}



