terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
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
  instance_types           = var.node_instance_types
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

module "ecr_user_authentication" {
  source          = "../modules/ecr"
  repository_name = "tech-challenge-user-authentication-repo"
}

module "ecr_user_authorizer" {
  source          = "../modules/ecr"
  repository_name = "tech-challenge-user-authorizer-repo"
}

module "ecr_notification_service" {
  source          = "../modules/ecr"
  repository_name = "tech-challenge-notification-service-repo"
}

# Catalog API Infrastructure
resource "aws_sns_topic" "catalog_events" {
  name = "catalog-events-topic"
}

module "ecr_catalog" {
  source          = "../modules/ecr"
  repository_name = "tech-challenge-catalog-api-repo"
}

module "sqs_catalog_events" {
  source     = "../modules/sqs"
  queue_name = "catalog-events-queue"
}

resource "aws_sns_topic_subscription" "catalog_events_sqs_target" {
  topic_arn = aws_sns_topic.catalog_events.arn
  protocol  = "sqs"
  endpoint  = module.sqs_catalog_events.queue_arn
}

resource "aws_sqs_queue_policy" "catalog_events_allow_sns" {
  queue_url = module.sqs_catalog_events.queue_url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "sqs:SendMessage"
        Resource  = module.sqs_catalog_events.queue_arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.catalog_events.arn
          }
        }
      }
    ]
  })
}

data "aws_caller_identity" "current" {}
