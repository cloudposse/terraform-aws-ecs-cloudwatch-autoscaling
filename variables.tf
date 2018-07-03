variable "name" {
  type        = "string"
  description = "Name (unique identifier for app or service)"
}

variable "namespace" {
  type        = "string"
  description = "Namespace (e.g. `cp` or `cloudposse`)"
}

variable "delimiter" {
  type        = "string"
  description = "The delimiter to be used in labels."
  default     = "-"
}

variable "stage" {
  type        = "string"
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
}

variable "attributes" {
  type        = "list"
  description = "List of attributes to add to label."
  default     = []
}

variable "tags" {
  type        = "map"
  description = "Map of key-value pairs to use for tags."
  default     = {}
}

variable "enabled" {
  type        = "string"
  description = "Whether to create all resources"
  default     = "true"
}

variable "min_capacity" {
  type        = "string"
  description = "Minimum number of running instances of a Service."
  default     = "1"
}

variable "max_capacity" {
  type        = "string"
  description = "Maximum number of running instances of a Service."
  default     = "2"
}

variable "cluster_name" {
  type        = "string"
  description = "The name of the ECS cluster where service is to be autoscaled."
}

variable "service_name" {
  type        = "string"
  description = "The name of the ECS Service to autoscale."
}

variable "scale_up_adjustment" {
  type        = "string"
  description = "Scaling adjustment to make during scale up event."
  default     = "1"
}

variable "scale_up_cooldown" {
  type        = "string"
  description = "Period (in seconds) to wait between scale up events."
  default     = "60"
}

variable "scale_down_adjustment" {
  type        = "string"
  description = "Scaling adjustment to make during scale down event."
  default     = "-1"
}

variable "scale_down_cooldown" {
  type        = "string"
  description = "Period (in seconds) to wait between scale down events."
  default     = "300"
}

variable "cpu_utilization_high_threshold" {
  type        = "string"
  description = "The maximum percentage of CPU utilization average."
  default     = "80"
}

variable "cpu_utilization_high_period" {
  type        = "string"
  description = "Duration in seconds to evaluate for the CPU Utilization High alarm."
  default     = "300"
}

variable "cpu_utilization_high_evaluation_periods" {
  type        = "string"
  description = "Number of periods to evaluate for the CPU Utilization High alarm."
  default     = "1"
}

variable "cpu_utilization_low_threshold" {
  type        = "string"
  description = "The minimum percentage of CPU utilization average."
  default     = "20"
}

variable "cpu_utilization_low_period" {
  type        = "string"
  description = "Duration in seconds to evaluate for the CPU Utilization Low alarm."
  default     = "300"
}

variable "cpu_utilization_low_evaluation_periods" {
  type        = "string"
  description = "Number of periods to evaluate for the CPU Utilization Low alarm."
  default     = "1"
}
