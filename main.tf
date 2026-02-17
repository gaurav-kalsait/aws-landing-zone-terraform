module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source    = "./modules/subnets"
  vpc_id    = module.vpc.vpc_id
  vpc_cidr  = var.vpc_cidr
}

module "networking" {
  source             = "./modules/networking"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.subnets.public_subnet_ids
  private_subnet_ids = module.subnets.private_subnet_ids
}

module "flow_logs" {
  source = "./modules/flow-logs"
  vpc_id = module.vpc.vpc_id
}
