
provider "azurerm" {
  version = "=1.21"

  #subscription_id             = "66391ae6-a4d7-4401-a643-245509f5c337"
  #client_id                   = "a14f94ef-6c2a-4a1f-a7cc-ea23ad338c87"
  #client_certificate_password = "1KFvffN2jZWb6nxmCvpBwOI0s16Owgr83EYZ4jVmGfI="
  #tenant_id                   = "bd8ab44a-b4f0-4055-b414-10d1a87c1666"
  
  
  subscription_id             = "66391ae6-a4d7-4401-a643-245509f5c337"
  client_id                   = "fa90cebf-8a20-4372-bfe5-36e78059beeb"
  client_certificate_path     = "service-principal.pfx"
  client_certificate_password = "Qwerty123456"
  tenant_id                   = "bd8ab44a-b4f0-4055-b414-10d1a87c1666"
}

resource "azurerm_resource_group" "default" {
  name     = "rg_beta"
  location = "canadacentral"
}

resource "random_string" "name" {
  length = 5
  special = false
  number = false
  override_special = "/@\" "
}

resource "azurerm_app_service_plan" "default" {
  name                = "tfex-appservice-beta-plan-${random_string.name.result}"
  location            = "${azurerm_resource_group.default.location}"
  resource_group_name = "${azurerm_resource_group.default.name}"

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "default" {
  name                = "tfex-appservice-beta-${random_string.name.result}"
  location            = "${azurerm_resource_group.default.location}"
  resource_group_name = "${azurerm_resource_group.default.name}"
  app_service_plan_id = "${azurerm_app_service_plan.default.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    remote_debugging_enabled = true
    remote_debugging_version = "VS2015"
  }
}
