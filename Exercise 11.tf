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
output "hotel_replaced" {
  value = replace(var.hotel, "[aeiou]", "*")
}
