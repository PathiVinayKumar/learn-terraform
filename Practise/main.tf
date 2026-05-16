provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "Test" {
  name = "Test" # Matches the existing name in your Azure portal
}

resource "azurerm_virtual_network" "Monolith-vnet" {
  name                = "Monolith-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Test.location
  resource_group_name = azurerm_resource_group.Test.name
}

resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.Test.name
  virtual_network_name = azurerm_virtual_network.Monolith-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "vinay913_z1" {
  name                = "vinay913_z1-nic"
  location            = azurerm_resource_group.Test.location
  resource_group_name = azurerm_resource_group.Test.name

  ip_configuration {
    name                          = "subnet"
    subnet_id                     = "/subscriptions/9e27705f-e28f-4f14-9137-ef3f4f8924af/resourceGroups/Test/providers/Microsoft.Network/virtualNetworks/Monolith-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "test1" {
  name                = "test1"
  resource_group_name = azurerm_resource_group.Test.name
  location            = azurerm_resource_group.Test.location
  disable_password_authentication = false
  size                = "Standard_F2"
  admin_username      = "vinay"
  admin_password      = "Vinny@123456789"
  network_interface_ids = [
    azurerm_network_interface.vinay913_z1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

# 2. Updated for RHEL 10 Image
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "10-gen2"
    version   = "latest"
  }
}