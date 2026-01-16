module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.28"

  vpc_id                         = var.vpc_id
  subnet_ids                     = var.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    general = {
      desired_size = 2
      min_size     = 1
      max_size     = 3
      instance_types = ["t3.medium"]
    }
  }
}

variable "cluster_name" {}
variable "vpc_id" {}
variable "private_subnets" { type = list(string) }
