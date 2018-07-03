module "cpu_utilization_high_alarm_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.1.3"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  attributes = "${compact(concat(var.attributes, list("autoscaling", "cpu", "utilization", "high")))}"
}

module "cpu_utilization_low_alarm_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.1.3"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  attributes = "${compact(concat(var.attributes, list("autoscaling", "cpu", "utilization", "low")))}"
}

locals {
  thresholds = {
    CPUUtilizationHighThreshold = "${min(max(var.cpu_utilization_high_threshold, 0), 100)}"
    CPUUtilizationLowThreshold  = "${min(max(var.cpu_utilization_low_threshold, 0), 100)}"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_high" {
  count               = "${local.enabled}"
  alarm_name          = "${module.cpu_utilization_high_alarm_label.id}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "${var.cpu_utilization_high_evaluation_periods}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "${var.cpu_utilization_high_period}"
  statistic           = "Average"
  threshold           = "${local.thresholds["CPUUtilizationHighThreshold"]}"

  dimensions {
    "ClusterName" = "${var.cluster_name}"
    "ServiceName" = "${var.service_name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.up.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_low" {
  count               = "${local.enabled}"
  alarm_name          = "${module.cpu_utilization_low_alarm_label.id}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "${var.cpu_utilization_low_evaluation_periods}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "${var.cpu_utilization_low_period}"
  statistic           = "Average"
  threshold           = "${local.thresholds["CPUUtilizationLowThreshold"]}"

  dimensions {
    "ClusterName" = "${var.cluster_name}"
    "ServiceName" = "${var.service_name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.down.arn}"]
}
