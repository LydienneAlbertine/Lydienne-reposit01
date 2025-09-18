# Append Hello before each name
variable "names_hello" {
  type    = list(string)
  default = ["Alice", "Bob", "Carol"]
}
locals {
  greetings = flatten([
    for n in var.names_hello : [ "Hello ${n}" ]
  ])
}
output "greetings" {
  value = local.greetings
}
