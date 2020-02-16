resource "azurerm_resource_group" "webapps" {
   name         = "webapps"
   location     = var.loc
   tags         = var.tags
}

resource "random_string" "webapprnd" {
  length  = 8
  lower   = true
  number  = true
  upper   = false
  special = false
}

resource "azurerm_app_service_plan" "free" {
     count              = length(var.nlocs)
    name                = "plan-free-${var.nlocs[count.index]}"
    location            = var.nlocs[count.index]
    resource_group_name = azurerm_resource_group.webapps.name
    tags                = azurerm_resource_group.webapps.tags
    
    kind                = "Linux"
    reserved            = true
    sku {
        tier = "Basic"
        size = "B1"
    }
}

resource "azurerm_app_service" "citadel" {
    count               = length(var.nlocs)
    name                = "webapp-${random_string.webapprnd.result}-${var.nlocs[count.index]}"
    location            = var.nlocs[count.index]
    resource_group_name = azurerm_resource_group.webapps.name
    tags                = azurerm_resource_group.webapps.tags

    app_service_plan_id = element(azurerm_app_service_plan.free.*.id, count.index)
}

output "webapp_ids" {
  value = "${azurerm_app_service.citadel.*.id}"
}
