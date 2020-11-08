output "primary_vpc_id" {
  value       = aws_vpc.primary-vpc.id
  description = "Output the ID of the primary VPC instance"
}

output "secondary_vpc_id" {
  value       = aws_vpc.secondary-vpc.id
  description = "Output the ID of the secondary VPC instance"
}