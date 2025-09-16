variable "subscription_id"{
  type=string
}
variable "client_id"{
  type=string
}
variable "client_secret"{
  type=string
}
variable "tenant_id"{
  type=string
}
variable "firstname"{
type=string
default="lydienne"
}
variable "lastname"{
type=string
default="albertine" 
}
variable "restaurant"{
type=string
default="cajun"
}
variable "restauranta"{
type=string
default="kee"
}
variable "restaurantb"{
type=string
default="heritage"
}
variable "restaurantc"{
type=string
default="maxi"
}
variable "restaurantd"{
type=string
default="goodfood"
} 
variable "millenium"{
type=number
default=2000
}
variable "truefalse"{
type=bool
default=true
}
variable"falsetrue"{
type=bool
default=false
}
variable "fruits"{
type=list(string)
default=["mango","apple","pineapple","melon","pawpaw"]
}
variable "movies"{
type=list(string)
default=["avengers","garfield","xmen","jumanji","johnwick"]
}
variable "icecream"{
type=list(string)
default=["caramel","oreo","vanilla","chocolate","banana"]
}
variable "songs"{
type=list(string)
default=["treasure","alive","helium","firewall","flowers"]
}
variable "colors"{
type=list(string)
default=["green","red","yellow","blue","black"]
}
variable "travels"{
type=list(string)
default=["neworlean","australia","hawai","malibu","newzealand"]
}
variable "app_name"{
type=string
default="my_app"
}
variable "items" {
  type    = list(string)
  default = ["one", "two", "three"]
}
variable "server_name" {
  type    = string
  default = "app-prod-01"
}
variable "items1" {
  type    = list(string)
  default = ["football", "handball", "tennis", "running","volleyball"]
}
variable "items2" {
  type    = list(string)
  default = ["football", "handball", "tennis", "running","volleyball"]
}

variable "movies1"{
type=list(string)
default=["badboys","avengers","superman","jumanji","airplane"]
}
variable "movie" {
  default = "Inception"
}
