terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket                      = "tech-challenge-bucket-andromeda-local"
    key                         = "terraform.tfstate"
    region                      = "us-east-1"
    endpoints                   = {
      s3 = "http://localhost:4566"
      iam = "http://localhost:4566"
      sts = "http://localhost:4566"
    }
    access_key                  = "test"
    secret_key                  = "test"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    ec2            = "http://localhost:4566"
    ecr            = "http://localhost:4566"
    eks            = "http://localhost:4566"
    rds            = "http://localhost:4566"
    iam            = "http://localhost:4566"
    sts            = "http://localhost:4566"
    s3             = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    cloudwatchlogs = "http://localhost:4566"
  }

  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "localstack"
      Project     = "tech-challenge"
    }
  }
}


locals {
  cluster_name = "eks-tech-challenge-local"
}

resource "aws_iam_role" "eks_local" {
  name = "eks-local-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

module "vpc" {

  source       = "../modules/vpc"
  cluster_name = local.cluster_name
}

module "eks" {
  source         = "../modules/eks"
  cluster_name   = local.cluster_name
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnets
  role_arn       = aws_iam_role.eks_local.arn
  role_name      = aws_iam_role.eks_local.name
  repository_url = module.ecr.repository_url
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
    Environment = "localstack"
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
  role_arn                       = aws_iam_role.eks_local.arn
  reserved_concurrent_executions = 3
  environment_variables = {
    DB_HOST            = module.rds.db_instance_endpoint
    DYNAMODB_TABLE     = "tech-challenge-tokens"
    PROJECT_ENV        = "localstack"
  }
}

module "lambda_user_authentication" {
  source                         = "../modules/lambda"
  function_name                  = "tech-challenge-user-authentication"
  image_uri                      = "${module.ecr_user_authentication.repository_url}:latest"
  role_arn                       = aws_iam_role.eks_local.arn
  reserved_concurrent_executions = 3
  environment_variables = {
    DYNAMODB_TABLE = "tech-challenge-tokens"
  }
}

module "lambda_notification_service" {
  source                         = "../modules/lambda"
  function_name                  = "tech-challenge-notification-service"
  image_uri                      = "${module.ecr_notification_service.repository_url}:latest"
  role_arn                       = aws_iam_role.eks_local.arn
  reserved_concurrent_executions = 3
}
