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

# Clusters AKS avec noms uniques
resource "azurerm_kubernetes_cluster" "aks1" {
  name                = var.aks_clusters["AKS1"].name
  location            = azurerm_resource_group.rg_aks_lyd["AKS1"].location
  resource_group_name = azurerm_resource_group.rg_aks_lyd["AKS1"].name
  dns_prefix          = var.aks_clusters["AKS1"].dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.aks_clusters["AKS1"].node_count
    vm_size    = var.aks_clusters["AKS1"].vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

resource "azurerm_kubernetes_cluster" "aks2" {
  name                = var.aks_clusters["AKS2"].name
  location            = azurerm_resource_group.rg_aks_lyd["AKS2"].location
  resource_group_name = azurerm_resource_group.rg_aks_lyd["AKS2"].name
  dns_prefix          = var.aks_clusters["AKS2"].dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.aks_clusters["AKS2"].node_count
    vm_size    = var.aks_clusters["AKS2"].vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

resource "azurerm_kubernetes_cluster" "aks3" {
  name                = var.aks_clusters["AKS3"].name
  location            = azurerm_resource_group.rg_aks_lyd["AKS3"].location
  resource_group_name = azurerm_resource_group.rg_aks_lyd["AKS3"].name
  dns_prefix          = var.aks_clusters["AKS3"].dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.aks_clusters["AKS3"].node_count
    vm_size    = var.aks_clusters["AKS3"].vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

resource "azurerm_kubernetes_cluster" "aks4" {
  name                = var.aks_clusters["AKS4"].name
  location            = azurerm_resource_group.rg_aks_lyd["AKS4"].location
  resource_group_name = azurerm_resource_group.rg_aks_lyd["AKS4"].name
  dns_prefix          = var.aks_clusters["AKS4"].dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.aks_clusters["AKS4"].node_count
    vm_size    = var.aks_clusters["AKS4"].vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

resource "azurerm_kubernetes_cluster" "aks5" {
  name                = var.aks_clusters["AKS5"].name
  location            = azurerm_resource_group.rg_aks_lyd["AKS5"].location
  resource_group_name = azurerm_resource_group.rg_aks_lyd["AKS5"].name
  dns_prefix          = var.aks_clusters["AKS5"].dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.aks_clusters["AKS5"].node_count
    vm_size    = var.aks_clusters["AKS5"].vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

# Outputs client_certificate uniques
output "client_certificate1" {
  value     = azurerm_kubernetes_cluster.aks1.kube_config[0].client_certificate
  sensitive = true
}

output "client_certificate2" {
  value     = azurerm_kubernetes_cluster.aks2.kube_config[0].client_certificate
  sensitive = true
}

output "client_certificate3" {
  value     = azurerm_kubernetes_cluster.aks3.kube_config[0].client_certificate
  sensitive = true
}

output "client_certificate4" {
  value     = azurerm_kubernetes_cluster.aks4.kube_config[0].client_certificate
  sensitive = true
}

output "client_certificate5" {
  value     = azurerm_kubernetes_cluster.aks5.kube_config[0].client_certificate
  sensitive = true
}

# Outputs kube_config uniques
output "kube_config1" {
  value     = azurerm_kubernetes_cluster.aks1.kube_config_raw
  sensitive = true
}

output "kube_config2" {
  value     = azurerm_kubernetes_cluster.aks2.kube_config_raw
  sensitive = true
}

output "kube_config3" {
  value     = azurerm_kubernetes_cluster.aks3.kube_config_raw
  sensitive = true
}

output "kube_config4" {
  value     = azurerm_kubernetes_cluster.aks4.kube_config_raw
  sensitive = true
}

output "kube_config5" {
  value     = azurerm_kubernetes_cluster.aks5.kube_config_raw
  sensitive = true
}
