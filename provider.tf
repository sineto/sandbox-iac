terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16.0"
    }
  }

  backend "s3" {
    bucket = "app-001-tfstate"
    key    = "sandbox/terraform.tfstate"
    region = "us-east-1"
  }

  required_version = "~> 1.2.1"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

# Data object is going to be holding all the available
# availability zones in the defined region
data "aws_availability_zones" "available" {
  state = "available"
}
