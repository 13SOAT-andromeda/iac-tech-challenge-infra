terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "tech-challenge-bucket-andromeda-aws"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "dev"
      Project     = "tech-challenge"
    }
  }
}

locals {
   cluster_name = "eks-tech-challenge"
}

module "vpc" {
  source       = "../modules/vpc"
  cluster_name = local.cluster_name
}

module "eks" {
  source                   = "../modules/eks"
  cluster_name             = local.cluster_name
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  role_arn                 = var.cluster_role_arn
  role_name                = var.role_name
  create_policy_attachment = false
  repository_url           = module.ecr.repository_url
}


module "rds" {
  source                = "../modules/rds"
  db_password           = var.db_password
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnets
  eks_security_group_id = module.eks.cluster_security_group_id
}

module "ecr" {
  source          = "../modules/ecr"
  repository_name = var.repository_name
}

module "s3" {
  source      = "../modules/s3"
  bucket_name = var.bucket_name
  tags = {
    Environment = "dev"
  }
}

module "ecr_user_validation" {
  source          = "../modules/ecr"
  repository_name = "tech-challenge-user-validation-repo"
}

module "ecr_user_authentication" {
  source          = "../modules/ecr"
  repository_name = "tech-challenge-user-authentication-repo"
}

module "ecr_notification_service" {
  source          = "../modules/ecr"
  repository_name = "tech-challenge-notification-service-repo"
}

module "lambda_user_validation" {
  source                         = "../modules/lambda"
  function_name                  = "tech-challenge-user-validation"
  image_uri                      = "${module.ecr_user_validation.repository_url}:latest"
  role_arn                       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.role_name}"
  reserved_concurrent_executions = 3
  environment_variables = {
    DB_HOST            = module.rds.db_instance_endpoint
    DYNAMODB_TABLE     = module.dynamodb.table_name
    PROJECT_ENV        = "dev"
  }
}

module "lambda_user_authentication" {
  source                         = "../modules/lambda"
  function_name                  = "tech-challenge-user-authentication"
  image_uri                      = "${module.ecr_user_authentication.repository_url}:latest"
  role_arn                       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.role_name}"
  reserved_concurrent_executions = 3
  environment_variables = {
    DYNAMODB_TABLE = module.dynamodb.table_name
  }
}

module "lambda_notification_service" {
  source                         = "../modules/lambda"
  function_name                  = "tech-challenge-notification-service"
  image_uri                      = "${module.ecr_notification_service.repository_url}:latest"
  role_arn                       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.role_name}"
  reserved_concurrent_executions = 3
}

module "dynamodb" {
  source     = "../modules/dynamodb"
  table_name = "user-authentication-token"
  hash_key   = "token_id"
}

data "aws_caller_identity" "current" {}

module "s3" {
  source      = "../modules/s3"
  bucket_name = var.bucket_name
  tags = {
    Environment = "dev"
  }
}

module "ecr_user_validation" {
  source          = "../modules/ecr"
  repository_name = "tech-challenge-user-validation-repo"
}

module "ecr_user_authentication" {
  source          = "../modules/ecr"
  repository_name = "tech-challenge-user-authentication-repo"
}

module "ecr_notification_service" {
  source          = "../modules/ecr"
  repository_name = "tech-challenge-notification-service-repo"
}

module "lambda_user_validation" {
  source                         = "../modules/lambda"
  function_name                  = "tech-challenge-user-validation"
  image_uri                      = "${module.ecr_user_validation.repository_url}:latest"
  role_arn                       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.role_name}"
  reserved_concurrent_executions = 3
  environment_variables = {
    DB_HOST            = module.rds.db_instance_endpoint
    DYNAMODB_TABLE     = module.dynamodb.table_name
    PROJECT_ENV        = "dev"
  }
}

module "lambda_user_authentication" {
  source                         = "../modules/lambda"
  function_name                  = "tech-challenge-user-authentication"
  image_uri                      = "${module.ecr_user_authentication.repository_url}:latest"
  role_arn                       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.role_name}"
  reserved_concurrent_executions = 3
  environment_variables = {
    DYNAMODB_TABLE = module.dynamodb.table_name
  }
}

module "lambda_notification_service" {
  source                         = "../modules/lambda"
  function_name                  = "tech-challenge-notification-service"
  image_uri                      = "${module.ecr_notification_service.repository_url}:latest"
  role_arn                       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.role_name}"
  reserved_concurrent_executions = 3
}

module "dynamodb" {
  source     = "../modules/dynamodb"
  table_name = "user-authentication-token"
  hash_key   = "token_id"
}

data "aws_caller_identity" "current" {}

module "api_gateway" {
  source = "../modules/api-gateway"

  name        = local.api_gateway_name
  description = local.api_gateway_description
}