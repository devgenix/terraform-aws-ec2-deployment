terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    # These will be passed via -backend-config in the workflow to keep it dynamic
    # bucket         = "..."
    # key            = "terraform.tfstate"
    # region         = "..."
    # dynamodb_table = "..."
    # encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
