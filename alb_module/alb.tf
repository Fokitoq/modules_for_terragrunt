
# Elastic load balancer creation
resource "aws_lb" "ASG_load_balancer" {
  name               = "ASG-ELB-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = aws_subnet.public_subnets[*].id
  tags = {
    Name = "ASG_Docker_ELBSG_${var.env}"
  }
}

# Configure listeners for the ELB, forward traffic to target group
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.ASG_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ASG_target_group.arn
  }
}
