provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = "http://localhost:4566"
    ecr = "http://localhost:4566"
    eks = "http://localhost:4566"
    rds = "http://localhost:4566"
    iam = "http://localhost:4566"
    sts = "http://localhost:4566"
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
  source       = "../modules/eks"
  cluster_name = local.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnets
  role_arn     = aws_iam_role.eks_local.arn
  role_name    = aws_iam_role.eks_local.name
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
