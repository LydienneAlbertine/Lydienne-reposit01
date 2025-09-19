variable "hotels_Hyatt" {
 default = ["Marriott", "Hilton", "Sheraton", "Hyatt"]
}
locals {
 hotels_Hyatt_upper = toset([for s in var.hotels_hyatt : upper(s)])
}
output "hotels_Hyatt_upper" {
 value = local.hotel_hyatt_upper
}
