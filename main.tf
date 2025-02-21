module "scale_up_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = ["up"]
  context    = module.this.context
}

module "scale_down_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = ["down"]
  context    = module.this.context
}

resource "aws_appautoscaling_target" "default" {
  count              = module.this.enabled ? 1 : 0
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
  tags               = module.this.tags
}

resource "aws_appautoscaling_policy" "up" {
  count              = module.this.enabled ? 1 : 0
  name               = module.scale_up_label.id
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_up_cooldown
    metric_aggregation_type = "Average"

    dynamic "step_adjustment" {
      for_each = var.scale_up_step_adjustments
      content {
        metric_interval_lower_bound = lookup(step_adjustment.value, "metric_interval_lower_bound", null)
        metric_interval_upper_bound = lookup(step_adjustment.value, "metric_interval_upper_bound", null)
        scaling_adjustment          = step_adjustment.value.scaling_adjustment
      }
    }
  }

  depends_on = [aws_appautoscaling_target.default]
}

resource "aws_appautoscaling_policy" "down" {
  count              = module.this.enabled ? 1 : 0
  name               = module.scale_down_label.id
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_down_cooldown
    metric_aggregation_type = "Average"

    dynamic "step_adjustment" {
      for_each = var.scale_down_step_adjustments
      content {
        metric_interval_lower_bound = lookup(step_adjustment.value, "metric_interval_lower_bound", null)
        metric_interval_upper_bound = lookup(step_adjustment.value, "metric_interval_upper_bound", null)
        scaling_adjustment          = step_adjustment.value.scaling_adjustment
      }
    }
  }

  depends_on = [aws_appautoscaling_target.default]
}
