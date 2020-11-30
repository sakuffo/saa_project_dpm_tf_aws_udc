
output "primary-vpc-id" {
  value       = aws_vpc.primary-vpc.id
  description = "Output the ID of the primary VPC instance"
  depends_on  = [aws_vpc.primary-vpc]
}

output "secondary_vpc_id" {
  value       = aws_vpc.secondary-vpc.id
  description = "Output the ID of the secondary VPC instance"
  depends_on  = [aws_vpc.secondary-vpc]
}

output "primary_loadbalancer_dns_name" {
  value       = aws_lb.primary_front_end_alb.dns_name
  depends_on  = [aws_lb.primary_front_end_alb]
  description = "DNS link for the load balancer which redirects to the 1 tier for primary VPC"
}

output "secondary_loadbalancer_dns_name" {
  value       = aws_lb.secondary_front_end_alb.dns_name
  depends_on  = [aws_lb.secondary_front_end_alb]
  description = "DNS link for the load balancer which redirects to the web tier for secondary VPC"
}


# output "primary_web_tier_instances" {
#  value = data.aws_instances.primary-web-tier-instances.ids
#  depends_on = [ data.aws_instances.primary-web-tier-instances ] 
#  description = "Instance IDs from the Primary VPC"
# }
# output "secondary_web_tier_instances" {
#  value = data.aws_instances.secondary-web-tier-instances.ids
#  depends_on = [ data.aws_instances.secondary-web-tier-instances ] 
#  description = "Instance IDs from the Primary VPC"
# }
# output "primary_db_tier_instances" {
#  value = data.aws_instances.primary-db-tier-instances.ids
#  depends_on = [ data.aws_instances.primary-db-tier-instances ] 
#  description = "Instance IDs from the Primary VPC"
# }
# output "secondary_db_tier_instances" {
#  value = data.aws_instances.secondary-db-tier-instances.ids
#  depends_on = [ data.aws_instances.secondary-db-tier-instances ] 
#  description = "Instance IDs from the Primary VPC"
# }
# output "primary_web_tier_count" {
#  value = length(data.aws_instances.primary-web-tier-instances.ids)
#  depends_on = [ data.aws_instances.primary-web-tier-instances ] 
#  description = "Instance Count from the Primary VPC"
# }
# output "secondary_web_tier_count" {
#  value = length(data.aws_instances.secondary-web-tier-instances.ids)
#  depends_on = [ data.aws_instances.secondary-web-tier-instances ]  
#  description = "Instance Count from the Primary VPC"
# }
# output "primary_db_tier_count" {
#  value = length(data.aws_instances.primary-db-tier-instances.ids)
#  depends_on = [ data.aws_instances.primary-db-tier-instances ] 
#  description = "Instance Count from the Secondary VPC"
# }
# output "secondary_db_tier_count" {
#  value = length(data.aws_instances.secondary-db-tier-instances.ids)
#  depends_on = [ data.aws_instances.secondary-db-tier-instances ]  
#  description = "Instance Count from the Secondary VPC"
# }