data "aws_instances" "primary-web-tier" {
  provider = aws.primary
  instance_tags = {
    Tier = "Web"
  }

  instance_state_names = ["running", "stopped"]
  depends_on           = [aws_instance.web-server-paz-a, aws_instance.web-server-paz-b]
}

data "aws_instances" "secondary-web-tier" {
  provider = aws.secondary
  instance_tags = {
    Tier = "Web"
  }

  instance_state_names = ["running", "stopped"]
  depends_on           = [aws_instance.web-server-saz-a, aws_instance.web-server-saz-b]
}

resource "aws_lb" "primary_front_end_alb" {
  provider           = aws.primary
  name               = "primary-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.primary-web-tier.id]
  subnets            = [aws_subnet.primary-subnet-01.id, aws_subnet.primary-subnet-02.id]

  tags = var.udc_default_tags
}
resource "aws_lb_target_group" "primary_front_end_tg" {
  provider = aws.primary
  name     = "primary-front-end-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.primary-vpc.id
  tags = var.udc_default_tags
}

resource "aws_lb_listener" "primary_front_end_listner" {
  provider          = aws.primary
  load_balancer_arn = aws_lb.primary_front_end_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.primary_front_end_tg.arn
  }

}

resource "aws_lb_target_group_attachment" "primary_front_end_attach" {
  provider         = aws.primary
  count            = length(data.aws_instances.primary-web-tier.ids)
  target_group_arn = aws_lb_target_group.primary_front_end_tg.arn
  target_id        = data.aws_instances.primary-web-tier.ids[count.index]
  port             = 80
}


resource "aws_lb_listener" "secondary_front_end_listner" {
  provider          = aws.secondary
  load_balancer_arn = aws_lb.secondary_front_end_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.secondary_front_end_tg.arn
  }
}


resource "aws_lb" "secondary_front_end_alb" {
  provider           = aws.secondary
  name               = "secondary-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.secondary-web-tier.id]
  subnets            = [aws_subnet.secondary-subnet-01.id, aws_subnet.secondary-subnet-02.id]

  tags = var.udc_default_tags
}

resource "aws_lb_target_group" "secondary_front_end_tg" {
  provider = aws.secondary
  name     = "secondary-front-end-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.secondary-vpc.id
  tags = var.udc_default_tags
}

resource "aws_lb_target_group_attachment" "secondary_front_end_attach" {
  provider         = aws.secondary
  count            = length(data.aws_instances.secondary-web-tier.ids)
  target_group_arn = aws_lb_target_group.secondary_front_end_tg.arn
  target_id        = data.aws_instances.secondary-web-tier.ids[count.index]
  port             = 80
}