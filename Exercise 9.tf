variable "hotels" {
 default = ["Marriott", "Hilton", "Sheraton", "Hyatt"]
}
locals {
 labels_upper = toset([for s in var.labels : upper(s)])
}
output "labels_upper" {
 value = local.labels_upper
