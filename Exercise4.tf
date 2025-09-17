variable "items" {
 type    = list(string)
 default = ["b", "a", "c", "a", "b"]
}
locals {
 unique_sorted = sort(distinct(var.items))
 csv           = join(",", local.unique_sorted)
}
output "unique_sorted" { value = local.unique_sorted }
output "csv"           { value = local.csv }

