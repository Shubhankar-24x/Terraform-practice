# Output for count

# output "ec2_public_ip" {
#   value = aws_instance.my-ec2[*].public_ip # Multiple instances (*)
# }

# output "ec2_public_dns" {
#   value = aws_instance.my-ec2.public_dns
# }

# output "ec2_private_ip" {
#   value = aws_instance.my-ec2.private_ip
  
# }

# Output for_each meta argument

output "ec2_public_ip" {
  value = { for instance in aws_instance.my-ec2 : instance.id => instance.public_ip }
}
