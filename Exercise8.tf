# Append Hello before each name
variable "names_hello" {
  type    = list(string)
  default = ["Alice", "Bob", "Carol"]
}
locals {
  hello = flatten([
    for name in var.names_hello : [ "Hello ${name}" ]
  ])
}
output "append_hello_name" {
  value = local.hello
}
