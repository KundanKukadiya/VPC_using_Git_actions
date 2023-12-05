resource "aws_alb" "alb" {
  name = "alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [ var.sg_id ]
  subnets = var.subnets
}

resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_alb.alb.arn
  port = "80"
  protocol = "HTTP"


  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.alb-target.arn
  }
}

resource "aws_alb_target_group" "alb-target" {
  name = "TG"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
}

resource "aws_alb_target_group_attachment" "TG-attach" {
  count = length(var.instance)
  target_group_arn = aws_alb_target_group.alb-target.arn
  target_id = var.instance[count.index]
  port = 80
}