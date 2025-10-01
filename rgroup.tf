# Définition des resource groups dans une map
variable "resource_groups" {
default = {
dev  = { location = "Canada Central" }
test = { location = "Canada Central" }
prod = { location = "Canada Central" }
  }
}

# Création des resource groups avec for_each
resource "azurerm_resource_group" "rglyd" {
for_each = var.resource_groups
name     = "rglyd_${each.key}"
location = each.value.location
}

