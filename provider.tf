terraform {
  required_version = ">= 0.15"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}



terraform {
  backend "s3" {
    bucket = "somterrafomtfstatebucket/"
   key    = "import3/terraform.tfstate"
    region = "ap-south-1"
  }
}

