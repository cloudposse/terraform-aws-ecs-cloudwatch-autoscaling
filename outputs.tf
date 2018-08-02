output "scale_up_policy_arn" {
  description = "ARN of the scale up policy."
  value       = "${join("", aws_appautoscaling_policy.up.*.arn)}"
}

output "scale_down_policy_arn" {
  description = "ARN of the scale down policy."
  value       = "${join("", aws_appautoscaling_policy.down.*.arn)}"
}
