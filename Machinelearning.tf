# =========================
# VARIABLES
# =========================
variable "tenant_id" {
  type        = string
  description = "AAD tenant ID (required for Key Vault access policy)"
}

variable "prefix" {
  type    = string
  default = "montrealitcollege"
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
  name                     = "${var.prefix}sa"
  resource_group_name      = azurerm_resource_group.mcitprefix_rg.name
  location                 = azurerm_resource_group.mcitprefix_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# =========================
# APPLICATION INSIGHTS
# =========================
resource "azurerm_application_insights" "mcitprefix_appi" {
  name                = "${var.prefix}-appi"
  location            = azurerm_resource_group.mcitprefix_rg.location
  resource_group_name = azurerm_resource_group.mcitprefix_rg.name
  application_type    = "web"
}

# =========================
# KEY VAULT
# =========================
resource "azurerm_key_vault" "mcitprefix_kv" {
  name                       = "${var.prefix}-kv"
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
  name                = "${var.prefix}-ws"
  location
