output "firstoutput"{
value=var.firstname
}
output "secondoutput"{
value=var.lastname
}
output "resto1"{
value=var.restaurant
}
output "resto2"{
value=var.restauranta
}
output "resto3"{
value=var.restaurantb
}
output "resto4"{
value=var.restaurantc
}
output "resto5"{
value=var.restaurantd
}
output "listnumber"{
value=var.millenium
}
output "trfl1"{
value=var.truefalse
}
output "trfl2"{
value=var.falsetrue
}
output "fruitlist"{
value=var.fruits
}
output "movieslist"{
value=var.movies
}
output "creamlist"{
value=var.icecream
}
output "songlist"{
value=var.songs
}
output "colorlistt"{
value=var.colors
}
output "travellist"{
value=var.travels
}
output "application_name"{
value=local.full_name
}
output "cvs_item"{
value=join(",",var.items)
}
output "server_name_parts" {
  value = split("-", var.server_name)
}
output "cvs_item1"{
value=join(",",var.items1)
}
output "listmovies1"{
value=var.movies1
}
output "movie_in_uppercase"{
value=local.movie_upper
}
output "movie_in_lowercase"{
value=local.movie_lower
}
output "replaced_string" {
  value = local.replaced 
}
output "first_word" {
  value = local.first_word # "Inception"
}
output "second_word" {
  value = local.second_word # "Movie"
}
output "mcit_student" {
  value = local.mcit_student # "mcit"
}
output "labels_upper" {
 value = local.labels_upper
}
