variable "hotels" {
 default = ["Marriott", "Hilton", "Sheraton", "Hyatt"]
}
locals {
 hotel_upper = toset([for s in var.hotels_hyatt : upper(s)])
}
output "hotel_upper" {
 value = local.hotel_hyatt_upper
}
