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
 default = "B11"
}
variable "project_app2" {
 type    = string
 default = "webapp2"
}
variable "location2" {
 type    = string
 default = "canadacentral"
}
# small-but-real SKU (B1 is cheap; P1v3 is production)
variable "plan1_sku_app2" {
 type    = string
 default = "B2"
}
variable "project_app3" {
 type    = string
 default = "webapp3"
}
variable "location3" {
 type    = string
 default = "canadacentral"
}
# small-but-real SKU (B1 is cheap; P1v3 is production)
variable "plan1_sku_app3" {
 type    = string
 default = "B3"
}
