provider "aws" {
  region = var.region
}

module "vpc" {
  source                  = "cloudposse/vpc/aws"
  version                 = "2.1.1"
  ipv4_primary_cidr_block = var.vpc_cidr_block
  context                 = module.this.context
}

module "subnets" {
  source               = "cloudposse/dynamic-subnets/aws"
  version              = "2.4.2"
  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  igw_id               = [module.vpc.igw_id]
  ipv4_cidr_block      = module.vpc.vpc_cidr_block
  nat_gateway_enabled  = true
  nat_instance_enabled = false
  context              = module.this.context
}

resource "aws_ecs_cluster" "default" {
  name = module.this.id
  tags = module.this.tags
}

module "container_definition" {
  source                       = "cloudposse/ecs-container-definition/aws"
  version                      = "0.45.2"
  container_name               = var.container_name
  container_image              = var.container_image
  container_memory             = var.container_memory
  container_memory_reservation = var.container_memory_reservation
  container_cpu                = var.container_cpu
  essential                    = var.container_essential
  readonly_root_filesystem     = var.container_readonly_root_filesystem
  environment                  = var.container_environment
  port_mappings                = var.container_port_mappings
}

module "ecs_alb_service_task" {
  source                             = "cloudposse/ecs-alb-service-task/aws"
  version                            = "0.42.0"
  alb_security_group                 = module.vpc.vpc_default_security_group_id
  container_definition_json          = module.container_definition.json_map_encoded_list
  ecs_cluster_arn                    = aws_ecs_cluster.default.arn
  launch_type                        = var.ecs_launch_type
  vpc_id                             = module.vpc.vpc_id
  security_group_ids                 = [module.vpc.vpc_default_security_group_id]
  subnet_ids                         = module.subnets.public_subnet_ids
  ignore_changes_task_definition     = var.ignore_changes_task_definition
  network_mode                       = var.network_mode
  assign_public_ip                   = var.assign_public_ip
  propagate_tags                     = var.propagate_tags
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_controller_type         = var.deployment_controller_type
  desired_count                      = var.desired_count
  task_memory                        = var.task_memory
  task_cpu                           = var.task_cpu
  context                            = module.this.context
}

module "ecs_cloudwatch_autoscaling" {
  source                = "../../"
  context               = module.this.context
  cluster_name          = aws_ecs_cluster.default.name
  service_name          = module.ecs_alb_service_task.service_name
  min_capacity          = var.min_capacity
  max_capacity          = var.max_capacity
  scale_up_adjustment   = var.scale_up_adjustment
  scale_up_cooldown     = var.scale_up_cooldown
  scale_down_adjustment = var.scale_down_adjustment
  scale_down_cooldown   = var.scale_down_cooldown
}
