variable "nums" {
 type    = list(number)
 default = [1,2,3,4,5,6]
}
locals {
 evens   = [for n in var.nums : n if n % 2 == 0]
 squares = [for n in local.evens : n * n]
}
output "evens"   { value = local.evens }
output "squares" { value = local.squares }
