# Terraform mínimo para testar só API Gateway no LocalStack.
# Use com: docker compose up -d && cd localstack/apigateway-only && tflocal init && tflocal apply

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway = "http://localhost:4566"
  }

  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "localstack"
      Project     = "tech-challenge"
    }
  }
}

module "api_gateway" {
  source = "../../modules/api-gateway"

  name        = var.api_name
  description = var.api_description
  tags        = var.tags
}
