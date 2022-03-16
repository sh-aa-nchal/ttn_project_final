module "network" {
  source = "./modules/network"
  main_vpc_cidr = var.vpc_cdr
  public_subnet1 =  var.public1_cdr
  public_subnet2 = var.public2_cdr
  private_subnets = var.private_cdr
}
  
module "alb" {
  source  = "./modules/alb"
  subnet1 = module.network.public_subnet1_id.id
  subnet2 = module.network.public_subnet2_id.id
  test-ip = var.ip-test
}
  
module "asg" {
  source = "./modules/asg"
  ami_id = var.ami-ins
  instance_type = var.ins-type
  desired_cap = var.desired-cap
  max_count = var.max-count
  min_count = var.min-count
  subnet1_id = module.network.public_subnet1_id
  subnet2_id = module.network.public_subnet2_id
  min_healthy = var.min-healthy
  
}
  
module "database" {
  source = "./modules/database"
  ami-db = var.db-ami
  instance-db = var.db-instance
  subnet-db = module.network.private_subnet_id
  sg-db  = module.alb.private-sg-id
  privateip-db = var.db-privateip
  
}
  
module "monitoring" {
  source = "./modules/monitoring"
  ami-mon = var.mon-ami
  instance-mon = var.mon-instance
  subnet-mon = module.network.private_subnet_id
  sg-mon  = module.alb.private-sg-id
  privateip-mon = var.mon-privateip
}
  
