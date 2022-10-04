
provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "Azure_WEB" {
  name     = "WS_WEB"
  location = "westeurope"
}

resource "azurerm_virtual_network" "Azure_WEB_network" {
    name                = "Network"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.Azure_WEB.location
    resource_group_name = azurerm_resource_group.Azure_WEB.name
}

resource "azurerm_subnet" "Azure_WEB_subnet" {
    name                 = "Subnet"
    resource_group_name  = azurerm_resource_group.Azure_WEB.name
    virtual_network_name = azurerm_virtual_network.Azure_WEB_network.name
    address_prefixes       = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "Azure_WEB_public_ip" {
    name                = "myPublicIP"
    location            = azurerm_resource_group.Azure_WEB.location
    resource_group_name = azurerm_resource_group.Azure_WEB.name
    allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "Azure_WEB_nsg" {
  name                = "myNetworkSecurityGroup"
  location            = azurerm_resource_group.Azure_WEB.location
  resource_group_name = azurerm_resource_group.Azure_WEB.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "RDP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "vm1-nic" {
    name                        = "vm1-NIC"
    location                    = azurerm_resource_group.Azure_WEB.location
    resource_group_name         = azurerm_resource_group.Azure_WEB.name

    ip_configuration {
        name                          = "vm1-NicConfiguration"
        subnet_id                     = azurerm_subnet.Azure_WEB_subnet.id
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.0.2.4"
        public_ip_address_id          = azurerm_public_ip.Azure_WEB_public_ip.id
    }

}


resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.vm1-nic.id
  network_security_group_id = azurerm_network_security_group.Azure_WEB_nsg.id
}

resource "azurerm_virtual_machine" "vm-1" {
  name                  = "vm1"
  location              = azurerm_resource_group.Azure_WEB.location
  resource_group_name   = azurerm_resource_group.Azure_WEB.name
  network_interface_ids = [azurerm_network_interface.vm1-nic.id]
  vm_size               = "Standard_B1s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "vm1-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "vm-1"
    admin_username = "alex"
    admin_password = "$om3s3cretPassWord"
  }

  os_profile_windows_config {
      enable_automatic_upgrades = "true"
      provision_vm_agent = "true"
  }
}
