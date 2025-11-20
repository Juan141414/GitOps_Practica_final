resource "aws_autoscaling_group" "web_asg" {
  name                      = "JuanWordpress-asg"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_min_size
  vpc_zone_identifier       = [for s in aws_subnet.public : s.id]
  health_check_type         = "ELB"
  health_check_grace_period = 120

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.web_tg.arn]

  tag {
    key                 = "Name"
    value               = "JuanWordpress-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "role"
    value               = "web"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

