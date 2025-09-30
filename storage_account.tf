# Variables (variables.tf)

# Resource Group
variable "rg_name" {
  type    = string
  default = "rg-lydienne"
}
variable "location_storage" {
  type    = string
  default = "West Europe"
}
# Virtual Network
variable "vnet_name" {
  type    = string
  default = "vnet-lydienne"
}
variable "address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}
# Subnet
variable "subnet_name" {
  type    = string
  default = "subnet-lydienne"
}
variable "subnet_prefix" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}
variable "service_endpoints" {
  type    = list(string)
  default = ["Microsoft.Sql", "Microsoft.Storage"]
}
# Storage Accounts
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
variable "account_tier" {
  type    = string
  default = "Standard"
}
variable "account_replication_type" {
  type    = string
  default = "LRS"
}
variable "ip_rules" {
  type    = list(string)
  default = ["100.0.0.1"]
}
variable "storage_tags" {
  type = map(string)
  default = {
    environment = "staging"
  }
}
# Resource Group
resource "azurerm_resource_group" "lydienne" {
  name     = var.rg_name
  location = var.location_storage
}
# Virtual Network
resource "azurerm_virtual_network" "lydienne_vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location_storage
  resource_group_name = azurerm_resource_group.lydienne.name
}
# Subnet
resource "azurerm_subnet" "lydienne_net" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.lydienne.name
  virtual_network_name = azurerm_virtual_network.lydienne_vnet.name
  address_prefixes     = var.subnet_prefix
  service_endpoints    = var.service_endpoints
}
# Storage Accounts
resource "azurerm_storage_account" "lydienne_account" {
  for_each = var.storage_account_lydienne

  name                     = each.value
  resource_group_name      = azurerm_resource_group.lydienne.name
  location                 = azurerm_resource_group.lydienne.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags                     = var.storage_tags
  network_rules {
    default_action             = "Deny"
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = [azurerm_subnet.lydienne_net.id]
  }
}
