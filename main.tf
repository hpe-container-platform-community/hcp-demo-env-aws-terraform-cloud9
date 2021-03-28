// Usage: terraform <action> -var-file="etc/bluedata_infra.tfvars"

provider "aws" {
  profile = var.profile
  region  = var.region
}

data "aws_availability_zone" "main" {
  name = var.az
}

resource "random_uuid" "deployment_uuid" {}

/******************* modules ********************/

module "network" {
  source                    = "./modules/module-network"
  project_id                = var.project_id
  user                      = var.user
  deployment_uuid           = random_uuid.deployment_uuid.result
  subnet_cidr_block         = var.subnet_cidr_block
  vpc_cidr_block            = var.vpc_cidr_block
  aws_zone_id               = data.aws_availability_zone.main.zone_id
}

resource "aws_cloud9_environment_ec2" "example" {
  instance_type = "t2.micro"
  name          = "example-env"
  subnet_id     = module.network.subnet_main_id
}
