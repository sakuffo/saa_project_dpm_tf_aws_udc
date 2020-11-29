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
