
module "vpc" {
  source = "./vpc_module"
}

module "sg" {
  source = "./sg_module"
}

module "ec2" {
  source = "./ec2_module"
}

module "cloudwatch" {
  source = "./cloudwatch_module"
}

module "autoscaling" {
  source = "./autoscaling_module"
}

module "alb" {
  source = "./alb_module"
}





output "vpc_output" {
  value = module.vpc.vpc_id
}

output "sg_output" {
  value = module.sg.instance_sg_id
}

output "cloudwatch_output" {
  value = module.cloudwatch.cpu_alarm_arn_up
}

output "autoscaling_output" {
  value = module.autoscaling.autoscaling_group_name
}

output "alb_output" {
  value = module.alb.load_balancer_dns_name
}