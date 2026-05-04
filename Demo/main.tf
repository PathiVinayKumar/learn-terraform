resource "azurerm_resource_group" "example_RSG" {
  name     = "example_RSG"
  location = "Denmark East (Zone 1)"
}


provider "azurerm" {
  features {}
}