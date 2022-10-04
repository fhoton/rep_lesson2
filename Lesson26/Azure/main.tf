terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.33"
    }
    
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.25.0"
    }  
  }

  required_version = ">= 1.2.0"
}