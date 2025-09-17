variable "usernames" {
 type    = list(string)
 default = ["alice", "bob", "carol"]
}
variable "domain" {
 type    = string
 default = "example.com"
}
locals {
 emails = { for u in var.usernames : u => "${u}@${var.domain}" }
}
output "emails" {
 value = local.emails
}
