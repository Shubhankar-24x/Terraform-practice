#Terraform AWS Provider

#Terraform Block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.87.0"
    }
  }
}

#Provider Block
provider "aws" {
  # Configuration options

  region="us-east-2"

}

