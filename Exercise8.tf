# Append Hello before each name
variable "names_hello" {
  type    = list(string)
  default = ["Alice", "Bob", "Carol"]
}
locals {
  hello = flatten([
    for n in var.names_hello : [ "Hello ${n}" ]
  ])
}
output "append_hello_name" {
  value = local.greetings
}
