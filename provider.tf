# Configure Terraform providers for AWS and Azure
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }
  }
  required_version = ">= 1.3.0"
}

# AWS provider
provider "aws" {
  region = "us-east-1"
}

# Azure provider
provider "azurerm" {
  features {}
}
