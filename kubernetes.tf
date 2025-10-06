# Groupe de ressources pour AKS
resource "azurerm_resource_group" "rg_aks" {
  name     = "rg_LYD4"
  location = "West Europe"
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-lydienne-LYD4"
  location            = azurerm_resource_group.rg_aks.location
  resource_group_name = azurerm_resource_group.rg_aks.name
  dns_prefix          = "lydienne-aks-4"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

# Outputs
output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}



# Groupe de ressources pour ACR
resource "azurerm_resource_group" "rg_acr" {
  name     = "rg_LYD5"
  location = "West Europe"
}

# Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "acrlydienneLYD5"
  resource_group_name = azurerm_resource_group.rg_acr.name
  location            = azurerm_resource_group.rg_acr.location
  sku                 = "Premium"
  admin_enabled       = false

  georeplications {
    location                = "East US"
    zone_redundancy_enabled = true
  }

  georeplications {
    location                = "North Europe"
    zone_redundancy_enabled = true
  }

  tags = {
    Environment = "Development"
  }
}

# Role Assignment pour connecter AKS au ACR
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

# Output du login server du registre
output "acr_login_server" {
  value     = azurerm_container_registry.acr.login_server
  sensitive = true
}

