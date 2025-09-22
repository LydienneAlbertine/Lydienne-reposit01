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
# Abbreviation from first letters (ESCTP)
variable "activities2" {
  default = ["eat", "sleep", "code", "travel", "play"]
}
locals {
  abbreviation = join("", [for a in var.activities : substr(a, 0, 1)])
}
output "activities2_abbr" {
  value = local.abbreviation
}
# Abbreviation with the first letter of each words
variable "activitiesok" {
  default = ["eat", "sleep", "code", "travel", "play"]
}

locals {
  abbreviations = join("", [
    for a in var.activitiesok : substr(a, 0, 1)
  ])
}

output "activities_abbr" {
  value = local.abbreviations
}
variable "foods" {
  default = ["Pizza", "Burger", "Sushi", "Tacos", "Pasta"]
}

# Créer une map avec longueur => mot
locals {
  food_lengths = { for f in var.foods : f => length(f) }
}

# Trouver la longueur max
locals {
  max_length = max([for l in local.food_lengths : l]...)
}

# Trouver le mot qui correspond à cette longueur
output "longest_food" {
  value = [for f, l in local.food_lengths : f if l == local.max_length][0]
}
