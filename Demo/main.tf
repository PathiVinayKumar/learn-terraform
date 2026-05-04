resource "azurerm_resource_group" "example_RSG" {
  name     = "example_RSG"
  location = "Denmark East"
}


provider "azurerm" {
  features {}
}