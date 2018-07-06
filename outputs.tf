output "aws_appautoscaling_policy_up_arn" {
  value = "${aws_appautoscaling_policy.up.arn}"
}

output "aws_appautoscaling_policy_down_arn" {
  value = "${aws_appautoscaling_policy.down.arn}"
}
