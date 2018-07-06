output "aws_appautoscaling_policy_up_arn" {
  description = "ARN of the scale up policy."
  value       = "${aws_appautoscaling_policy.up.arn}"
}

output "aws_appautoscaling_policy_down_arn" {
  description = "ARN of the scale down policy."
  value       = "${aws_appautoscaling_policy.down.arn}"
}
