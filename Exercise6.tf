variable "names" {
 type    = list(string)
 default = ["amy", "adam", "bob", "brian", "carol"]
}
locals {
 initials = toset([for n in var.names : substr(n, 0, 1)])
 grouped  = {
   for i in local.initials :
   i => [for n in var.names : n if substr(n, 0, 1) == i]
 }
}
output "grouped_by_initial" { value = local.grouped }

