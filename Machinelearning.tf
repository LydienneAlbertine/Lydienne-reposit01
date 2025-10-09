# VARIABLES
variable "tenant_id" {
  type        = string
  description = "AAD tenant ID (required for Key Vault access policy)"
}

variable "prefix" {
  type    = string
  default = "montrealitcollege"
}

# RANDOM STRING (pour noms uniques)
resource "random_string" "mcitprefix_random" {
  length  = 6
  upper   = false
  special = false
}

# RESOURCE GROUP
resource "azurerm_resource_group" "mcitprefix_rg" {
  name     = "mcitrg"
  location = var.location
}

# STORAGE ACCOUNT
resource "azurerm_storage_account" "mcitprefix_sa" {
  name                     = "${var.prefix}sa${random_string.mcitprefix_random.result}"
  resource_group_name      = azurerm_resource_group.mcitprefix_rg.name
  location                 = azurerm_resource_group.mcitprefix_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# APPLICATION INSIGHTS
resource "azurerm_application_insights" "mcitprefix_appi" {
  name                = "${var.prefix}-appi"
  location            = azurerm_resource_group.mcitprefix_rg.location
  resource_group_name = azurerm_resource_group.mcitprefix_rg.name
  application_type    = "web"
}

# KEY VAULT
resource "azurerm_key_vault" "mcitprefix_kv" {
  name                       = "${var.prefix}-kv"
  resource_group_name        = azurerm_resource_group.mcitprefix_rg.name
  location                   = azurerm_resource_group.mcitprefix_rg.location
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = true
  soft_delete_retention_days = 7
}

# MACHINE LEARNING WORKSPACE
resource "azurerm_machine_learning_workspace" "mcitprefix_ws" {
  name                     = "${var.prefix}-ws"
  location                 = azurerm_resource_group.mcitprefix_rg.location
  resource_group_name      = azurerm_resource_group.mcitprefix_rg.name
  storage_account_id       = azurerm_storage_account.mcitprefix_sa.id
  key_vault_id             = azurerm_key_vault.mcitprefix_kv.id
  application_insights_id  = azurerm_application_insights.mcitprefix_appi.id
  sku_name                 = "Basic"

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "dev"
  }
}

# KEY VAULT ACCESS POLICY
resource "azurerm_key_vault_access_policy" "mcitprefix_kv_policy" {
  key_vault_id = azurerm_key_vault.mcitprefix_kv.id
  tenant_id    = var.tenant_id
  object_id    = azurerm_machine_learning_workspace.mcitprefix_ws.identity[0].principal_id

  secret_permissions      = ["Get", "List", "Set", "Delete", "Purge", "Recover", "Backup", "Restore"]
  key_permissions         = ["Get", "Create", "Delete", "List"]
  certificate_permissions = ["Get", "List"]
}

# MACHINE LEARNING COMPUTE CLUSTER
resource "azurerm_machine_learning_compute_cluster" "mcitprefix_cpu" {
  name                          = "${var.prefix}-cpu"
  location                      = azurerm_resource_group.mcitprefix_rg.location
  machine_learning_workspace_id = azurerm_machine_learning_workspace.mcitprefix_ws.id
  vm_priority                   = "LowPriority"
  vm_size                       = "STANDARD_DS3_V2"

  scale_settings {
    min_node_count                   = 0
    max_node_count                   = 1
    scale_down_nodes_after_idle_duration = "PT30M"
  }
}

# OUTPUTS
output "resource_group" {
  value = azurerm_resource_group.mcitprefix_rg.name
}

output "workspace_name" {
  value = azurerm_machine_learning_workspace.mcitprefix_ws.name
}
