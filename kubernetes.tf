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


variable "aks_clusters" {
  description = "Paramètres pour créer plusieurs AKS"
  type = map(object({
    name       = string
    dns_prefix = string
    location   = string
    node_count = number
    vm_size    = string
    rg_name    = string
  }))
  default = {
    "AKS1" = { name = "aks-LYDIENNE1", dns_prefix = "lydienne-aks-1", location = "West Europe", node_count = 2, vm_size = "Standard_DS2_v2", rg_name = "rg_aks_lyd1" }
    "AKS2" = { name = "aks-LYDIENNE2", dns_prefix = "lydienne-aks-2", location = "West Europe", node_count = 2, vm_size = "Standard_DS2_v2", rg_name = "rg_aks_lyd2" }
    "AKS3" = { name = "aks-LYDIENNE3", dns_prefix = "lydienne-aks-3", location = "West Europe", node_count = 2, vm_size = "Standard_DS2_v2", rg_name = "rg_aks_lyd3" }
    "AKS4" = { name = "aks-LYDIENNE4", dns_prefix = "lydienne-aks-4", location = "West Europe", node_count = 2, vm_size = "Standard_DS2_v2", rg_name = "rg_aks_lyd4" }
    "AKS5" = { name = "aks-LYDIENNE5", dns_prefix = "lydienne-aks-5", location = "West Europe", node_count = 2, vm_size = "Standard_DS2_v2", rg_name = "rg_aks_lyd5" }
  }
}
# Resource groups pour chaque AKS
resource "azurerm_resource_group" "rg_aks_lyd" {
  for_each = var.aks_clusters
  name     = each.value.rg_name
  location = each.value.location
}

# Clusters AKS1 avec for_each
resource "azurerm_kubernetes_cluster" "aks1" {
  for_each            = var.aks_clusters
  name                = each.value.name
  location            = azurerm_resource_group.rg_aks_lyd[each.key].location
  resource_group_name = azurerm_resource_group.rg_aks_lyd[each.key].name
  dns_prefix          = each.value.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = each.value.node_count
    vm_size    = each.value.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

# Outputs client_certificate dynamiques
output "client_certificates_aks1" {
  value     = { for k, aks1 in azurerm_kubernetes_cluster.aks1 : k => aks1.kube_config[0].client_certificate }
  sensitive = true
}

# Outputs kube_config dynamiques
output "kube_configs_aks1" {
  value     = { for k, aks1 in azurerm_kubernetes_cluster.aks1 : k => aks1.kube_config_raw }
  sensitive = true
}
