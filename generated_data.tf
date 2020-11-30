# data "aws_instances" "primary-web-tier-instances" {
#   provider = aws.primary
#   instance_tags = {
#     Tier = "Web"
#   }

#   instance_state_names = ["running"]
#   depends_on           = [aws_instance.web-server-paz-a, aws_instance.web-server-paz-b ]
# }

# data "aws_instances" "secondary-web-tier-instances" {
#   provider = aws.secondary
#   instance_tags = {
#     Tier = "Web"
#   }

#   instance_state_names = ["running"]
#   depends_on           = [aws_instance.web-server-saz-a, aws_instance.web-server-saz-b ]
# }

# data "aws_instances" "primary-db-tier-instances" {
#   provider = aws.primary
#   instance_tags = {
#     Tier = "DB"
#   }

#   instance_state_names = ["running"]
#   depends_on           = [aws_instance.web-server-paz-a, aws_instance.web-server-paz-b ]
# }
# data "aws_instances" "secondary-db-tier-instances" {
#   provider = aws.primary
#   instance_tags = {
#     Tier = "DB"
#   }

#   instance_state_names = ["running"]
#   depends_on           = [aws_instance.web-server-paz-a, aws_instance.web-server-paz-b ]
# }