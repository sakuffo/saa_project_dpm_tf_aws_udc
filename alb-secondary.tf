# Application Loadbalancer 
resource "aws_lb" "secondary_front_end_alb" {
  provider           = aws.secondary
  name               = "secondary-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.secondary-web-tier.id]
  subnets            = [aws_subnet.secondary-subnet-01.id, aws_subnet.secondary-subnet-02.id]

  tags = var.udc_default_tags
}

# Target Group / Port 80 only
resource "aws_lb_target_group" "secondary_front_end_tg" {
  provider = aws.secondary
  name     = "secondary-front-end-tg"
  port     = var.http-traffic-port
  protocol = "HTTP"
  vpc_id   = aws_vpc.secondary-vpc.id
  tags     = var.udc_default_tags
}

# Application Loadbalancer Listeners
# Listening only on port 80 because SSL cert was not provisioned
resource "aws_lb_listener" "secondary_front_end_listner" {
  provider          = aws.secondary
  load_balancer_arn = aws_lb.secondary_front_end_alb.arn
  port              = var.http-traffic-port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.secondary_front_end_tg.arn
  }
}

# ALB Target Group attachment for public az-a
resource "aws_lb_target_group_attachment" "secondary_front_end_attach_a" {
  provider         = aws.secondary
  target_group_arn = aws_lb_target_group.secondary_front_end_tg.arn
  count            = var.secondary-web.count
  target_id        = aws_instance.web-server-saz-a[count.index].id
  port             = var.http-traffic-port
}

# ALB Target Group attachment for public az-b
resource "aws_lb_target_group_attachment" "secondary_front_end_attach_b" {
  provider         = aws.secondary
  target_group_arn = aws_lb_target_group.secondary_front_end_tg.arn
  count            = var.secondary-web.count
  target_id        = aws_instance.web-server-saz-b[count.index].id
  port             = var.http-traffic-port
}

