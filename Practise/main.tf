provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "Test" {
  name     = "Test"
  location = "Denmark East (Zone 1)"
}

resource "azurerm_virtual_network" "Monolith-vnet" {
  name                = "Monolith-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Monolith-vnet.location
  resource_group_name = azurerm_resource_group.Monolith-vnet.name
}

resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "vinay913_z1" {
  name                = "vinay913_z1-nic"
  location            = azurerm_resource_group.vinay913_z1.location
  resource_group_name = azurerm_resource_group.vinay913_z1.name

  ip_configuration {
    name                          = "subnet"
    subnet_id                     = "/subscriptions/9e27705f-e28f-4f14-9137-ef3f4f8924af/resourceGroups/Test/providers/Microsoft.Network/virtualNetworks/Monolith-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "test1" {
  name                = "test1"
  resource_group_name = azurerm_resource_group.test1.name
  location            = azurerm_resource_group.test1.location
  size                = "Standard_F2"
  admin_username      = "vinay"
  network_interface_ids = [
    azurerm_network_interface.vinay913_z1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}