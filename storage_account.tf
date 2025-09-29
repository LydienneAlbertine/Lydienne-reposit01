variable "location_storage" {
  type    = string
  default = "West Europe"
}
variable "storage_account_lydienne" {
  type = map(string)
  default = {
    s1  = "storageaccountlydienne1"
    s2  = "storageaccountlydienne2"
    s3  = "storageaccountlydienne3"
    s4  = "storageaccountlydienne4"
    s5  = "storageaccountlydienne5"
    s6  = "storageaccountlydienne6"
    s7  = "storageaccountlydienne7"
    s8  = "storageaccountlydienne8"
    s9  = "storageaccountlydienne9"
    s10 = "storageaccountlydienne10"
  }
}

variable "address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}
variable "subnet_prefix" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}

variable "service_endpoints" {
  type    = list(string)
  default = ["Microsoft.Sql", "Microsoft.Storage"]
}
variable "ip_rules" {
  type    = list(string)
  default = ["100.0.0.1"]
}
resource "azurerm_resource_group" "lydienne" {
  name     = "rg-lydienne"
  location = var.location_storage
}

resource "azurerm_virtual_network" "lydienne_vnet" {
  name                = "vnet-lydienne"
  address_space       = var.address_space
  location            = var.location_storage
  resource_group_name = azurerm_resource_group.lydienne.name
}

resource "azurerm_subnet" "lydienne_net" {
  name                 = "subnet-lydienne"
  resource_group_name  = azurerm_resource_group.lydienne.name
  virtual_network_name = azurerm_virtual_network.lydienne_vnet.name
  address_prefixes     = var.subnet_prefix
  service_endpoints    = var.service_endpoints
}

resource "azurerm_storage_account" "lydienne_account" {
  for_each = var.storage_account_lydienne
  name                     = each.value
  resource_group_name      = azurerm_resource_group.lydienne.name
  location                 = azurerm_resource_group.lydienne.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  network_rules {
    default_action             = "Deny"
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = [azurerm_subnet.lydienne_net.id]
  }
tags = {
environment="staging"
}
