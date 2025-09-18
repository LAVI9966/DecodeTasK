terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.44.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.2"
    }
  }
}

provider "azurerm" {
  features {}
   subscription_id = "c62ca5da-d507-41b1-9d1c-6a671b5ff9e7"
   tenant_id       = "a927b05b-71c6-4fdd-8c31-191eca0cd843"
   client_id       = "8bcdfe66-ecec-446a-8b39-fb7b87875719"
   client_secret   = "bWT8Q~xbkgXn4XleRL~ipUZl3-XwGr5ouGXEBbp6"
   
}

provider "random" {}