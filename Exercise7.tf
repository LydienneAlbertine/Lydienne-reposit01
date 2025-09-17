variable "words" {
 type    = list(string)
 default = ["hi", "cat", "car", "tree", "hi", "car"]
}
locals {
 lengths_unique = toset([for w in var.words : length(w)])
 histogram = {
   for L in local.lengths_unique :
   tostring(L) => length([for w in var.words : w if length(w) == L])
 }
}
output "length_histogram" { value = local.histogram }
