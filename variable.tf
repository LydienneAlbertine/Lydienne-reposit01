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
variable "fruit1"
type=list(string)
default=["mango","apple","melon","pineapple","pawpaw"]
}
