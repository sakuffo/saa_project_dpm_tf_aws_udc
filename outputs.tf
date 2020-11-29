output "primary-vpc-id" {
  value       = aws_vpc.primary-vpc.id
  description = "Output the ID of the primary VPC instance"
  depends_on  = [aws_vpc.primary-vpc]
}

output "secondary-vpc-id" {
  value       = aws_vpc.secondary-vpc.id
  description = "Output the ID of the secondary VPC instance"
  depends_on  = [aws_vpc.secondary-vpc]
}

output "primary-loadbalancer-dns-name" {
  value       = aws_lb.primary_front_end_alb.dns_name
  depends_on = [ aws_lb.primary_front_end_alb ]
}

output "secondary-loadbalancer-dns-name" {
  value       = aws_lb.secondary_front_end_alb.dns_name
  depends_on = [ aws_lb.secondary_front_end_alb ]
}