#convert lower case to upper case
variable "labels" {
 type    = set(string)
 default = ["alpha", "beta", "gamma"]
}
locals {
 labels_upper = toset([for s in var.labels : upper(s)])
}
output "labels_upper" {
 value = local.labels_upper
}
