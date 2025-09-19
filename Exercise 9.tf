variable "hotels" {
  default = ["Marriott", "Hilton", "Sheraton", "Hyatt"]
}

locals {
  formatted_hotels = [
    for h in var.hotels :
    (h == "Hyatt" ? upper(h) : h)
  ]
}

output "formatted_hotels" {
  value = local.formatted_hotels
}
