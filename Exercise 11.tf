# Replace a symbol or a word
variable "foods" {
 default = ["pizza", "burger", "sushi", "tacos"]
}
output "replace_burger" {
 value = replace("burger", "bur", "cheese")
}
variable "replace_Marriott" {
 default = ["Marriott"]
}
output "replace_Marriott" {
 value = replace_Marriott("Marriott", → "M*rr**tt")
}
