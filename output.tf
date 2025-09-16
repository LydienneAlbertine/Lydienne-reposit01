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
output "inception_upper"{
value=upper(var.inception1)
}
output "inception_lower"{
value=lower(var.inception2)
}
