# ⿡ Resource Group
resource "azurerm_resource_group" "rgwaf" {
  name     = "rg-waf-example"
  location = "Canada Central"
}
#  Virtual Network + Subnet
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-waf"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-waf"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
# Public IP
resource "azurerm_public_ip" "pip" {
  name                = "pip-waf"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
# ⿤ WAF Policy
resource "azurerm_web_application_firewall_policy" "waf_policy" {
  name                = "example-waf-policy"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  # Règle personnalisée pour bloquer une IP spécifique
  custom_rules {
    name      = "block_bad_ip"
    priority  = 1
    rule_type = "MatchRule"
    action    = "Block"

    match_conditions {
      match_variables {
        variable_name = "RemoteAddr"
      }
      operator          = "IPMatch"
      negation_condition = false
      match_values      = ["10.0.0.1"]
    }
  }
  # Règles OWASP standard
  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }
}
# ⿥ Application Gateway avec WAF Policy attachée
resource "azurerm_application_gateway" "appgw" {
  name                = "appgw-waf-example"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }
  gateway_ip_configuration {
    name      = "gatewayIpConfig"
    subnet_id = azurerm_subnet.subnet.id
  }
frontend_port {
    name = "httpPort"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "publicFrontend"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
  backend_address_pool {
    name = "defaultBackendPool"
  }
  backend_http_settings {
    name                  = "defaultBackendHttpSettings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }
http_listener {
    name                           = "listener"
    frontend_ip_configuration_name = "publicFrontend"
    frontend_port_name             = "httpPort"
    protocol                       = "Http"
  }
  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "listener"
    backend_address_pool_name  = "defaultBackendPool"
    backend_http_settings_name = "defaultBackendHttpSettings"
  }
  waf_configuration {
    enabled                          = true
    firewall_mode                     = "Prevention"  # ou "Detection"
    web_application_firewall_policy_id = azurerm_web_application_firewall_policy.waf_policy.id
  }
}










