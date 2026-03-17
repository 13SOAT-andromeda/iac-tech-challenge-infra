module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 3.0"

  name          = var.name
  description   = var.description
  protocol_type = "HTTP"

  create_api_domain_name = false

  tags = var.tags
}