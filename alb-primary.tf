# Application Loadbalancer 
resource "aws_lb" "primary_front_end_alb" {
  provider           = aws.primary
  name               = "primary-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.primary-web-tier.id]
  subnets            = [aws_subnet.primary-subnet-01.id, aws_subnet.primary-subnet-02.id]

  tags = var.udc_default_tags
}

# Target Group / Port 80 only
resource "aws_lb_target_group" "primary_front_end_tg" {
  provider = aws.primary
  name     = "primary-front-end-tg"
  port     = var.http-traffic-port
  protocol = "HTTP"
  vpc_id   = aws_vpc.primary-vpc.id
  tags     = var.udc_default_tags
}

# Application Loadbalancer Listeners
# Listening only on port 80 because SSL cert was not provisioned
resource "aws_lb_listener" "primary_front_end_listner" {
  provider          = aws.primary
  load_balancer_arn = aws_lb.primary_front_end_alb.arn
  port              = var.http-traffic-port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.primary_front_end_tg.arn
  }

}

# ALB Target Group attachment for public az-a
resource "aws_lb_target_group_attachment" "primary_front_end_attach_a" {
  provider         = aws.primary
  target_group_arn = aws_lb_target_group.primary_front_end_tg.arn
  count            = var.primary-web.count
  target_id        = aws_instance.web-server-paz-a[count.index].id
  port             = var.http-traffic-port
}

# ALB Target Group attachment for public az-b
resource "aws_lb_target_group_attachment" "primary_front_end_attach_b" {
  provider         = aws.primary
  target_group_arn = aws_lb_target_group.primary_front_end_tg.arn
  count            = var.primary-web.count
  target_id        = aws_instance.web-server-paz-b[count.index].id
  port             = var.http-traffic-port
}



