variable "locations6" {
  type    = list(string)
  default = ["Australia East","Canada Central","East US","Japan East","West Europe"]
}
resource "azurerm_resource_group" "rg6" {
  name     = "rg6-multi-apps"
  location = "Canada Central"
}
resource "azurerm_service_plan" "example" {
  for_each = toset(var.locations6)

  name                = "plan-${replace(each.key, " ", "")}"
  location            = each.key
  resource_group_name = azurerm_resource_group.rg6.name
  os_type             = "Windows"
  sku_name            = "B1"
}

resource "azurerm_windows_web_app" "example" {
  for_each = toset(var.locations6)

  name                = "webapp6-${replace(lower(each.key), " ", "")}"
  location            = each.key
  resource_group_name = azurerm_resource_group.rg6.name
  service_plan_id     = azurerm_service_plan.example[each.key].id

  site_config {}
}
output "webapps6" {
  value = {
    for loc, app in azurerm_windows_web_app.example :
    loc => app.default_hostname
  }
}
