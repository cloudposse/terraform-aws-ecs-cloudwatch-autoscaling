module "scale_up_label" {
  source     = "cloudposse/label/null"
  version    = "0.23.0"
  attributes = ["up"]
  context    = module.this.context
}

module "scale_down_label" {
  source     = "cloudposse/label/null"
  version    = "0.23.0"
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

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = var.scale_up_adjustment
    }
  }
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

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = var.scale_down_adjustment
    }
  }
}
