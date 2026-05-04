provider "azurerm" {
  features {}
}

resource "azurerm_network_interface" "main" {
  name                = "test-nic"
  location            = "Denmark East"
  resource_group_name = "Test"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "/subscriptions/9e27705f-e28f-4f14-9137-ef3f4f8924af/resourceGroups/Test/providers/Microsoft.Network/virtualNetworks/Monolith-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                  = "test-vm"
  location              = "Denmark East"
  resource_group_name   = "Test"
  network_interface_ids = [azurerm_network_interface.main.id]
  size               = "Standard_D2s_v3"

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  source_image_id = "/subscriptions/9e27705f-e28f-4f14-9137-ef3f4f8924af/resourceGroups/Test/providers/Microsoft.Compute/galleries/rhel10/images/1.0.0"

  os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
  }

    admin_username = "vinay"
    admin_password = "Vinny@123456789"
 

   disable_password_authentication = false
  

  # These properties are typically part of a newer resource type (azurerm_linux_virtual_machine)
  # but added here for syntax compatibility with your snippet
  secure_boot_enabled = true
  vtpm_enabled        = true
}
 
