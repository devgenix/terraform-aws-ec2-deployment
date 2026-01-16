module "vpc" {
  source = "./modules/vpc"
  region = var.region
}

module "ec2" {
  source     = "./modules/ec2"
  vpc_id     = module.vpc.vpc_id
  subnet_id  = module.vpc.public_subnets[0]
}

module "eks" {
  source          = "./modules/eks"
  cluster_name    = "devgenix-eks-prod"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}
