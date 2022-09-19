terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.23.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "prefix" {
  default = "LES20"
}

resource "azurerm_resource_group" "att" {
  name     = "azure-terraform-test"
  location = "West Europe"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.att.location
  resource_group_name = azurerm_resource_group.att.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.att.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.128.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.att.location
  resource_group_name = azurerm_resource_group.att.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.att.location
  resource_group_name   = azurerm_resource_group.att.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"
  
  storage_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "21h1-pro"
    version   = "19043.2006.220909"
  }

  storage_os_disk {
    name                 = "myosdisk1"
    managed_disk_type    = "Standard_LRS"
    caching              = "ReadWrite"
    create_option        = "FromImage"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
}