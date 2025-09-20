# Replace a symbol or a word
variable "foods" {
 default = ["pizza", "burger", "sushi", "tacos"]
}
output "replace_burger" {
 value = replace("burger", "bur", "cheese")
}
# Replace a vowel with this axterix symbol

variable "word" {
  default = "Marriott"
}
locals {
  vowels = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
  replace = join("", [
    for char in split("", var.word) :
    contains(local.vowels, char) ? "*" : char
  ])
}

output "masked_word" {
  value = local.replace
}
variable "hotels2" {
  default = ["Hilton", "Sheraton", "Marriott"]
}
# Begin with the two first letters of each word

locals {
  reversed_hotels2 = [
    for h in var.hotels2 : join("", reverse(split("", h))) ]
}
output "reversed_hotels2" {
  value = local.reversed_hotels2
}
variable "hotels3" {
  default = ["Hilton", "Marriott", "Sheraton", "Hyatt"]
}
locals {
  hotel2_short = [for h in var.hotels2 : substr(h, 0, 2) ]
}
output "short_hotels2" {
  value = local.hotel2_short
}
# variable "foods" {

  default = ["Pizza", "Burger", "Sushi", "Tacos"]

}

# Count total characters of all foods combined
 variable "foods3" {
  default = ["Pizza", "Burger", "Sushi", "Tacos"]
}
locals {
  total_chars = sum([
    for f in var.foods3 : length(f)  ])
}
output "total_characters" {
  value = local.total_chars
}
