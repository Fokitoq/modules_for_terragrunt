
# Auto scaling group definition
resource "aws_autoscaling_group" "Docker_ASG" {
  name                      = "Docker_ASG${var.env}"
  vpc_zone_identifier       = aws_subnet.public_subnets[*].id
  launch_configuration      = aws_launch_configuration.ASG_launch_config.name
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300
  health_check_type         = "EC2"
  target_group_arns         = [aws_lb_target_group.ASG_target_group.arn]

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
    ]

  metrics_granularity = "1Minute"

  tag {
    key                 = "Name"
    value               = "ASG_Docker_EC2_${var.env}" #name for EC2 instances created by ASG
    propagate_at_launch = true
  }

}




# Target group definition
resource "aws_lb_target_group" "ASG_target_group" {
  name        = "ASG-target-group-${var.env}"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.ASG_Docker_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    interval            = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

# Attach target group to your auto-scaling group
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.Docker_ASG.name
  lb_target_group_arn  = aws_lb_target_group.ASG_target_group.arn
}