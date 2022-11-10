provider "aws" {
  region = "us-east-1"
}

module "network_base" {
  source = "./network-base"

}

module "network_connective" {
  source   = "./network-connective"
  vpc_1_id = module.network_base.vpc_1_id

  public_subnets = [
    module.network_base.public_subnet_a_id,
    module.network_base.public_subnet_b_id,
    module.network_base.public_subnet_c_id
  ]

  private_subnets = [
    module.network_base.private_subnet_a_id,
    module.network_base.private_subnet_b_id,
    module.network_base.private_subnet_c_id
  ]

  vpc_1_cird = module.network_base.vpc_1_cird
  depends_on = [
    module.network_base
  ]
}




