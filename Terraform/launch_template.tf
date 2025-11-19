resource "aws_launch_template" "web_lt" {
  name_prefix   = "JuanWordpress-web-lt-"
  image_id      = data.aws_ami.ubuntu_2204.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.wordpress_keypair.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              set -e
              # minimal packages so Ansible can connect (python3 must be present)
              apt-get update -y
              apt-get install -y python3 python3-apt openssh-server curl
              EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "JuanWordpress-asg-instance"
      role = "web"
    }
  }
}
