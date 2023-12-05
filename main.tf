module "vpc" {
  source   = "./Modules/vpc"
  vpc_cidr = var.vpc_cidr
  subnets  = var.subnets
}

module "sg" {
  source = "./Modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source  = "./Modules/ec2"
  sg_id   = module.sg.sg_id
  subnets = module.vpc.subnet_id
}

module "alb" {
  source = "./Modules/alb"
  sg_id = module.sg.sg_id
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.subnet_id
  instance = module.ec2.instance
}