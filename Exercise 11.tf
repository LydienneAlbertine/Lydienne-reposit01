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
  replaced = join("", [
    for char in split("", var.word) :
    contains(local.vowels, char) ? "*" : char
  ])
}

output "masked_word" {
  value = local.replaced
}
