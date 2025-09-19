# Replace a symbol or a word
variable "foods" {
 default = ["pizza", "burger", "sushi", "tacos"]
}
output "replace_burger" {
 value = replace("burger", "bur", "cheese")
}
variable "Marriott" {
 default = ["pizza", "burger", "sushi", "tacos"]
}
output "replace_Marriott" {
 value = replace("Marriott", "M*rr**tt")
}
