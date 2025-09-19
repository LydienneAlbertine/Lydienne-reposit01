# Replace a symbol or a word
variable "foods" {
 default = ["pizza", "burger", "sushi", "tacos"]
}
output "replace_burger" {
 value = replace("burger", "bur", "cheese")
}
# Replace a vowel with this axterix symbol

variable "hotel" {
  default = "Marriott"
}

output "hotel_masked" {
  value = join("", [for c in split("", var.hotel) : contains(["a","e","i","o","u","A","E","I","O","U"], c) ? "*" : c])
}
