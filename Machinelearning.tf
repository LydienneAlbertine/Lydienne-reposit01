# MACHINE LEARNING WORKSPACE
# =========================

resource "azurerm_machine_learning_workspace" "mcitprefix_ws" {
  name                = "mcitprefix-mlw"
  location            = azurerm_resource_group.mcitprefix_rg.location
  resource_group_name = azurerm_resource_group.mcitprefix_rg.name
  sku_name            = "Basic"
  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "dev"
    project     = "mcitprefix"
  }
}

# =========================
# STORAGE ACCOUNT
# =========================

resource "azurerm_storage_account" "mcitprefix_sa" {
  name                     = "mcitprefixstorage"
  resource_group_name      = azurerm_resource_group.mcitprefix_rg.name
  location                 = azurerm_resource_group.mcitprefix_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# =========================
# MACHINE LEARNING COMPUTE CLUSTER
# =========================

resource "azurerm_machine_learning_compute_cluster" "mcitprefix_cpu" {
  name                          = "cpu-cluster"
  location                      = azurerm_resource_group.mcitprefix_rg.location
  machine_learning_workspace_id = azurerm_machine_learning_workspace.mcitprefix_ws.id
  vm_priority                   = "Dedicated"
  vm_size                       = "STANDARD_DS11_V2"
  scale_settings {
    min_node_count                   = 0
    max_node_count                   = 2
    scale_down_nodes_after_idle_duration = "PT15M"
  }

  tags = {
    environment = "dev"
    project     = "mcitprefix"
  }
}
