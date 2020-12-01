
output "primary_vpc_id" {
  value       = aws_vpc.primary-vpc.id
  description = "Output the ID of the primary VPC instance"
}

output "secondary_vpc_id" {
  value       = aws_vpc.secondary-vpc.id
  description = "Output the ID of the secondary VPC instance"
}

output "primary_loadbalancer_dns_name" {
  value       = aws_lb.primary_front_end_alb == true ? "No ALB Found" : aws_lb.primary_front_end_alb.dns_name
  description = "DNS link for the load balancer which points to teh web tier in Primary VPC"
}

output "secondary_loadbalancer_dns_name" {
  value       = aws_lb.secondary_front_end_alb == true ? "No ALB Found" : aws_lb.secondary_front_end_alb.dns_name
  description = "DNS link for the load balancer which points to teh web tier in Secondary VPC"
}


output "primary_web_tier_instances_az_a" {
  value = {
    for ec2_web in aws_instance.web-server-paz-b : ec2_web.id => ec2_web.id
  }
  description = "Instance IDs from the Primary VPC Web Tier"
}

output "primary_web_tier_instances_az_b" {
  value = {
    for ec2_web in aws_instance.web-server-paz-b : ec2_web.id => ec2_web.id
  }
  description = "Instance IDs from the Primary VPC Web Tier"
}
output "secondary_web_tier_instances" {
  value = {
    for ec2_web in aws_instance.web-server-saz-a : ec2_web.id => ec2_web.id
  }
  description = "Instance IDs from the Secondary VPC Web Tier"
}
output "primary_db_tier_instances" {
  value = {
    for ec2_web in aws_instance.db-paz-a : ec2_web.id => ec2_web.id
  }
  description = "Instance IDs from the Primary VPC DB Tier"
}
output "secondary_db_tier_instances" {
  value = {
    for ec2_db in aws_instance.db-saz-b : ec2_db.id => ec2_db.id
  }
  description = "Instance IDs from the Secondary VPC DB Tier"
}
output "primary_web_tier_count" {
  value       = var.primary-web.count * var.public_subnet_count
  description = "Web Instance Count from the Primary VPC"
}
output "secondary_web_tier_count" {
  value       = var.secondary-web.count * var.public_subnet_count
  description = "Web Instance Count from the Secondary VPC"
}
output "primary_db_tier_count" {
  value       = var.primary-db.count
  description = "DB Count from the Primary VPC"
}
output "secondary_db_tier_count" {
  value       = var.secondary-db.count
  description = "DB Count from the Secondary VPC"
}