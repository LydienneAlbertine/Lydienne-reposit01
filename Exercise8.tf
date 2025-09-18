# Append Hello before each name
variable "names" {
  type    = list(string)
  default = ["Alice", "Bob", "Carol"]
}
locals {
  greetings = []
}
locals {
  greetings = flatten([
    for n in var.names : [ "Hello ${n}" ]
  ])
}
output "greetings" {
  value = local.greetings
}
