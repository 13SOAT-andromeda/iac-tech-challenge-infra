provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}

locals {
  cluster_name = "eks-tech-challenge-local"
}

module "vpc" {
  source       = "../modules/vpc"
  cluster_name = local.cluster_name
}

module "eks" {
  source          = "../modules/eks"
  cluster_name    = local.cluster_name
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  role_arn        = var.cluster_role_arn
  node_role_arn   = var.node_role_arn
  access_role_arn = var.access_role_arn
}