variable "location_storage" {
  type    = string
  default = "West Europe"
}
variable "storage_account_lydienne" {
type = map (string)
default = {
s1= "storage_account_lydienne1"
s2= "storage_account_lydienne2"
s3= "storage_account_lydienne3"
s4= "storage_account_lydienne4"
s5= "storage_account_lydienne5"
s6= "storage_account_lydienne6"
s7= "storage_account_lydienne7"
s8= "storage_account_lydienne8"
s9= "storage_account_lydienne9"
s10= "storage_account_lydienne10"
}
}
variable "azurerm_virtual_network_lydienne1"  {
type = list (number)
default      = ["10.0.0.0/16"]
 }
resource "azurerm_subnet" "lydienne_net" {
  name                 = "subnetname"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

resource "azurerm_storage_account" "lydienne_account1" {
for_each= var.storage_account_lydienne
  name                = each.value
  resource_group_name = azurerm_resource_group_lydienne

  location                 = azurerm_resource_group.location_storage
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["100.0.0.1"]
    virtual_network_subnet_ids = [azurerm_subnet.example.id]
  }

  tags = {
    environment = "staging"
  }
}
