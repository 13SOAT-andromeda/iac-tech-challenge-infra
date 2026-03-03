module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  iam_role_arn            = var.role_arn
  create_iam_role         = false
  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = false
  enable_irsa = false
  authentication_mode = "API_AND_CONFIG_MAP"
  access_entries = {
    local_admin = {
      principal_arn = var.access_role_arn
      type          = "STANDARD"
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
    voclabs_admin = {
      principal_arn = "arn:aws:iam::186319076937:role/voclabs"
      type          = "STANDARD"
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  kms_key_administrators = [var.role_arn]
  kms_key_users          = [var.role_arn, var.node_role_arn]

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t3.medium"]
      ami_type = "AL2023_x86_64_STANDARD"
      iam_role_arn = var.node_role_arn
      create_iam_role = false
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
