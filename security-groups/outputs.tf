output "private_security_group_id" {
  description = "The ID of the private server security_group"
  value       = module.security_gp.security_group_id
}

output "public_elb_security_group_id" {
  description = "The ID of the public ALB security_group"
  value       = module.public_alb_sg.security_group_id
}