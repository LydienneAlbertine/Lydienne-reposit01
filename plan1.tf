# Multiple Web Apps from a list (list → toset → for_each)
variable "apps" {
default = ["inovocb-api", "riidoz-ui", "gamecb-core"]
}
 
resource "azurerm_service_plan" "plan" {
name                = "asp-shared"
location            = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
os_type             = "Linux"
sku_name            = "B1"
}
 
resource "azurerm_linux_web_app" "app" {
for_each          = toset(var.apps)
name                = each.value
location            = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
service_plan_id     = azurerm_service_plan.plan.id
 
site_config {
application_stack {
node_version = "18-lts"

    }

  }

}

# [Variable Block
 
variable "apps": Defines a variable called apps.
 
default = ["inovocb-api", "riidoz-ui", "gamecb-core"]: The default value is a list with three web app names. These will be used later to create multiple apps.
 
Service Plan Resource
 
resource "azurerm_service_plan" "plan": This creates an Azure App Service Plan, with the local Terraform name plan.
 
name = "asp-shared": The actual Azure name of the service plan will be asp-shared.
 
location = azurerm_resource_group.rg.location: The plan will be created in the same region as the resource group rg.
 
resource_group_name = azurerm_resource_group.rg.name: The plan will belong to the same resource group rg.
 
os_type = "Linux": Specifies that this plan is for Linux apps.
 
sku_name = "B1": The pricing tier will be B1 (Basic), which is an entry-level paid tier.
 
This means you are creating one shared App Service Plan for all your apps.
 
Linux Web App Resource
 
resource "azurerm_linux_web_app" "app": Declares an Azure Linux Web App resource, with the Terraform name app.
 
for_each = toset(var.apps): Loops over the list of app names defined in the variable, turning it into a set. Terraform will create one Web App for each item (inovocb-api, riidoz-ui, gamecb-core).
 
name = each.value: The name of each Web App will be set to the current item from the list.
 
location = azurerm_resource_group.rg.location: Each Web App is deployed in the same region as the resource group.
 
resource_group_name = azurerm_resource_group.rg.name: Each Web App belongs to the same resource group.
 
service_plan_id = azurerm_service_plan.plan.id: All the Web Apps share the same App Service Plan created earlier (asp-shared).
 
Inside the site_config block:
 
site_config {}: Configures settings for the app.
 
application_stack {}: Defines the runtime environment.
 
node_version = "18-lts": Each Web App will run on Node.js version 18 LTS.
 
Final Result
 
One shared App Service Plan named asp-shared.
 
Three separate Linux Web Apps created automatically from the list:
inovocb-api 
riidoz-ui 
gamecb-core 
All three apps run on Linux + Node.js 18, inside the same plan and resource group.]
