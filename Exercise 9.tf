variable "hotels" {
 default = ["Marriott", "Hilton", "Sheraton", "Hyatt"]
}
locals {
 hotel_Hyatt_upper = toset([for s in var.hotels_hyatt : upper(s)])
}
output "hotel_Hyatt_upper" {
 value = local.hotel_hyatt_upper
}
