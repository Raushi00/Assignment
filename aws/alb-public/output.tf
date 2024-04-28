output "target_group_arns" {
  description = "ARNs of the target groups. Useful for passing to your Auto Scaling group."
  value       = module.public_alb.target_group_arns
}