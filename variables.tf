variable "min_capacity" {
  type        = number
  description = "Minimum number of running instances of a Service"
  default     = 1
}

variable "max_capacity" {
  type        = number
  description = "Maximum number of running instances of a Service"
  default     = 2
}

variable "cluster_name" {
  type        = string
  description = "The name of the ECS cluster where service is to be autoscaled"
}

variable "service_name" {
  type        = string
  description = "The name of the ECS Service to autoscale"
}

variable "scale_up_cooldown" {
  type        = number
  description = "Period (in seconds) to wait between scale up events"
  default     = 60
}

variable "scale_down_cooldown" {
  type        = number
  description = "Period (in seconds) to wait between scale down events"
  default     = 300
}

variable "scale_up_step_adjustments" {
  type = list(object({
    metric_interval_lower_bound = optional(number)
    metric_interval_upper_bound = optional(number)
    scaling_adjustment          = number
  }))
  description = "List of step adjustments for scale up policy"
  default = [{
    metric_interval_lower_bound = 0
    metric_interval_upper_bound = null
    scaling_adjustment          = 1
  }]
}

variable "scale_down_step_adjustments" {
  type = list(object({
    metric_interval_lower_bound = optional(number)
    metric_interval_upper_bound = optional(number)
    scaling_adjustment          = number
  }))
  description = "List of step adjustments for scale down policy"
  default = [{
    metric_interval_lower_bound = null
    metric_interval_upper_bound = 0
    scaling_adjustment          = -1
  }]
}
