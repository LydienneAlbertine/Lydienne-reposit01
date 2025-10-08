# =========================
# VARIABLES
# =========================
variable "tenant_id" {
  type        = string
  description = "AAD tenant ID (required for Key Vault access policy)"
}

# =========================
# RESOURCE GROUP
# =========================
resource "azurerm_resource_group" "mcitprefix_rg" {
  name     = "mcitrg"
  location = "canadacentral"
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
# KEY VAULT
# =========================
resource "azurerm_key_vault" "mcitprefix_kv" {
  name                       = "mcitprefix-kv"
  resource_group_name        = azurerm_resource_group.mcitprefix_rg.name
  location                   = azurerm_resource_group.mcitprefix_rg.location
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = true
  soft_delete_retention_days = 7
}

# =========================
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
}

# =========================
# KEY VAULT ACCESS POLICY
# =========================
resource "azurerm_key_vault_access_policy" "mcitprefix_kv_policy" {
  key_vault_id = azurerm_key_vault.mcitprefix_kv.id
  tenant_id    = var.tenant_id
  object_id    = azurerm_machine_learning_workspace.mcitprefix_ws.identity[0].principal_id

  secret_permissions      = ["Get", "List", "Set", "Delete", "Purge", "Recover", "Backup", "Restore"]
  key_permissions         = ["Get", "Create", "Delete", "List"]
  certificate_permissions = ["Get", "List"]
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
}
