output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = [for s in aws_subnet.public : s.id]
}

output "private_subnets" {
  value = [for s in aws_subnet.private : s.id]
}

output "nat_gateways" {
  value = [for n in aws_nat_gateway.nat : n.id]
}

output "alb_dns_name" {
  value = aws_lb.web_alb.dns_name
}

output "asg_name" {
  value = aws_autoscaling_group.web_asg.name
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.address
}
