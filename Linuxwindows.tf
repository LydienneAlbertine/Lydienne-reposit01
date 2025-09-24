variable "locations" {
  type    = list(string)
  default = [
    "Australia East",
    "Canada Central",
    "East US",
    "Japan East",
    "West Europe"
  ]
}
resource "azurerm_resource_group" "rg" {
  name     = "rg-multi-apps"
  location = "Canada Central"
}
resource "azurerm_service_plan" "example" {
  for_each = toset(var.locations)

  name                = "plan-${replace(each.key, " ", "")}"
  location            = each.key
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name            = "B1"
}

resource "azurerm_windows_web_app" "example" {
  for_each = toset(var.locations)

  name                = "webapp-${replace(lower(each.key), " ", "")}"
  location            = each.key
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.example[each.key].id

  site_config {}
}
output "webapps" {
  value = {
    for loc, app in azurerm_windows_web_app.example :
    loc => app.default_hostname
  }
}
