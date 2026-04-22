locals {
  cluster_name = "eks-tech-challenge-local"
}

resource "aws_iam_role" "eks_local" {
  name = "eks-local-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Principal = { Service = "eks.amazonaws.com" } }]
  })
}

module "vpc" {
  source       = "../modules/vpc"
  cluster_name = local.cluster_name
}

# No LocalStack PRO, o EKS funciona como uma camada sobre o Docker/K3s
module "eks" {
  source         = "../modules/eks"
  cluster_name   = local.cluster_name
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnets
  role_arn       = aws_iam_role.eks_local.arn
  role_name      = aws_iam_role.eks_local.name
  repository_url = module.ecr_api.repository_url
}

module "ecr_api" {
  source          = "../modules/ecr"
  repository_name = "tech-challenge-repo"
}

module "ecr_auth" {
  source          = "../modules/ecr"
  repository_name = "tech-challenge-user-authentication-repo"
}

module "ecr_authz" {
  source          = "../modules/ecr"
  repository_name = "tech-challenge-user-authorizer-repo"
}

module "ecr_notif" {
  source          = "../modules/ecr"
  repository_name = "tech-challenge-notification-service-repo"
}

# Lambdas Reais (PackageType Image)
module "lambda_user_authentication" {
  source        = "../modules/lambda"
  function_name = "tech-challenge-user-authentication"
  package_type  = "Image"
  image_uri     = "${module.ecr_auth.repository_url}:${var.image_tag}"
  role_arn      = aws_iam_role.eks_local.arn
  environment_variables = {
    DB_SSLMODE = "disable" # LocalStack não exige SSL por padrão
    PROJECT_ENV = "localstack"
  }
}

module "lambda_user_authorizer" {
  source        = "../modules/lambda"
  function_name = "tech-challenge-user-authorizer"
  package_type  = "Image"
  image_uri     = "${module.ecr_authz.repository_url}:${var.image_tag}"
  role_arn      = aws_iam_role.eks_local.arn
}

module "lambda_notification_service" {
  source        = "../modules/lambda"
  function_name = "tech-challenge-notification-service"
  package_type  = "Image"
  image_uri     = "${module.ecr_notif.repository_url}:${var.image_tag}"
  role_arn      = aws_iam_role.eks_local.arn
}
