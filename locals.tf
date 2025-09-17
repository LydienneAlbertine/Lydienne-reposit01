locals {
full_name="${var.app_name}-prod"
}
locals {
  movie_lower = lower(var.movie) # "inception"
  movie_upper = upper(var.movie) # "INCEPTION"
}
locals {
  replaced = replace(var.original, "MCIT", "Montreal College")
}
locals {
  first_word = substr(var.phrase, 0, 9) # start at index 0, length 9
}
locals {
  second_word = substr(var.phrase, 9, 5) # start at index 9, length 5
}  
}
locals {
  code_student = substr(var.phrase, 2, 4) # start at index 2, length 4
} 
