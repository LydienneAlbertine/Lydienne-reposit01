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

