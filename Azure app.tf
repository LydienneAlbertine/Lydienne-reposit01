variable "project_name" {
 type    = string
 default = "mywebapp"
}
variable "location" {
 type    = string
 default = "canadacentral"
}
# small-but-real SKU (B1 is cheap; P1v3 is production)
variable "plan_sku_name" {
 type    = string
 default = "B1"
}
variable "project_app1" {
 type    = string
 default = "webapp1"
}
variable "location1" {
 type    = string
 default = "canadacentral"
}
# small-but-real SKU (B11 is cheap; P1v3 is production)
variable "plan1_sku_app1" {
 type    = string
 default = "B2"
}
variable "project_webapp2" {
  default = ["app2", "app3", "app4", "app5"]
}

resource "azurerm_resource_group" "rg2" {
  name     = "${var.project_webapps}-rg2"
  location = var.location2
}

resource "azurerm_service_plan" "plan2" {
  name                = "${var.project_webapp2}-plan2"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name

  os_type  = "Linux"
  sku_name = var.plan2_sku_app2
}
