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
  value = replace(replace(replace(replace(replace(var.hotel, "a",""), "e",""), "i",""), "o",""), "u","*")
}
