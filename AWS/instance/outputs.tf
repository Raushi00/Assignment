# EC2 Complete
output "apinode1_instance_id" {
  description = "The ID of the instance"
  value       = module.ec2_instance.id
}

output "apinode1_instance_arn" {
  description = "The ARN of the instance"
  value       = module.ec2_instance.arn
}