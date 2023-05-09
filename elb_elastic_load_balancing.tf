resource "aws_alb_target_group" "arn_aws_elasticloadbalancing_ap_south_1_585772678898_targetgroup_prodtg_4bad7725a71e859f" {
  deregistration_delay = "300"
  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = aws_iam_policy.arn_aws_iam__585772678898_policy_allow_ec2_access.path
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  load_balancing_algorithm_type = "round_robin"
  name                          = "PRODTG"
  port                          = 80
  protocol                      = "HTTP"
  protocol_version              = "HTTP1"
  stickiness {
    cookie_duration = 86400
    type            = "lb_cookie"
  }

  target_type = "instance"
  vpc_id      = aws_vpc.my_vpc.id
}

resource "aws_alb_target_group_attachment" "i_027f1d87fe41e91cf_80_arn_aws_elasticloadbalancing_ap_south_1_585772678898_targetgroup_prodtg_4bad7725a71e859f" {
  port             = 80
  target_group_arn = aws_alb_target_group.arn_aws_elasticloadbalancing_ap_south_1_585772678898_targetgroup_prodtg_4bad7725a71e859f.arn
  target_id        = aws_instance.webserver2.id
}

resource "aws_alb_target_group_attachment" "i_0603bd45478dc5362_80_arn_aws_elasticloadbalancing_ap_south_1_585772678898_targetgroup_prodtg_4bad7725a71e859f" {
  port             = 80
  target_group_arn = aws_alb_target_group.arn_aws_elasticloadbalancing_ap_south_1_585772678898_targetgroup_prodtg_4bad7725a71e859f.arn
  target_id        = aws_instance.webserver1.id
}

