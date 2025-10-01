# Plans with for_each (map → multiple App Service Plans)
variable "plans" {
default = {
dev  = { sku = "B1", worker_count = 1 }
prod = { sku = "P1v3", worker_count = 2 }
 }
}
 
resource "azurerm_service_plan" "asp" {
for_each            = var.plans
name                = "asp-${each.key}"
location            = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
os_type             = "Linux"
sku_name            = each.value.sku
worker_count        = each.value.worker_count
}
 
# Inside the Resource:
for_each = var.plans
Instead of creating just one service plan, Terraform will create one per key in var.plans (so one for dev and one for prod).
 
In each iteration, each.key is the environment name (dev or prod),
 
each.value is the object ({ sku = "...", worker_count = ... }).
name = "asp-${each.key}"

Sets the Azure resource name. It will dynamically become:
asp-dev for the dev plan
 
asp-prod for the prod plan
 
sku_name = each.value.sku

Gets the sku from the object defined in var.plans.
 
For dev → "B1"
 
For prod → "P1v3"
 
 
worker_count = each.value.worker_count

Gets the worker_count (number of workers) from the plan object.
 
For dev → 1
 
For prod → 2
 
Terraform will create two service plans automatically:
 
asp-dev (Linux, B1, 1 worker)
 
asp-prod (Linux, P1v3, 2 workers)
 
