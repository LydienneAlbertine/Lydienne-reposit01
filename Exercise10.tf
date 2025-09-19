# Put a list of things with an arrow symbol
variable "activities" {
  default = ["eat", "sleep", "code", "repeat"]
}

locals {
  list_activities = "→ ${join(" → ", var.activities)}"
}

output "activities_string" {
  value = local.list_activities
}
