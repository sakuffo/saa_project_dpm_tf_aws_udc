output "primary-vpc-id" {
  value       = aws_vpc.primary-vpc.id
  description = "Output the ID of the primary VPC instance"
}

output "secondary-vpc-id" {
  value       = aws_vpc.secondary-vpc.id
  description = "Output the ID of the secondary VPC instance"
}

output "primary-subnet-01" {
  value       = aws_subnet.primary-subnet-01.id
  description = "Output the ID of the primary VPC instance"
}

output "primary-subnet-02" {
  value       = aws_subnet.primary-subnet-02.id
  description = "Output the ID of the secondary VPC instance"
}

output "secondary-subnet-01" {
  value       = aws_subnet.secondary-subnet-01.id
  description = "Output the ID of the primary VPC instance"
}

output "secondary-subnet-02" {
  value       = aws_subnet.secondary-subnet-02.id
  description = "Output the ID of the secondary VPC instance"
}