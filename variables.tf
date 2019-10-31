variable "namespace" {
  type        = string
  description = "Namespace (e.g. `eg` or `cp`)"
  default     = ""
}

variable "stage" {
  type        = string
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  default     = ""
}

variable "name" {
  type        = string
  description = "Name of the application"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  description = "Additional attributes (_e.g._ \"1\")"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Additional tags (_e.g._ { BusinessUnit : ABC })"
  default     = {}
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Enable/disable resources creation"
}

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

variable "scale_up_adjustment" {
  type        = number
  description = "Scaling adjustment to make during scale up event"
  default     = 1
}

variable "scale_up_cooldown" {
  type        = number
  description = "Period (in seconds) to wait between scale up events"
  default     = 60
}

variable "scale_down_adjustment" {
  type        = number
  description = "Scaling adjustment to make during scale down event"
  default     = -1
}

variable "scale_down_cooldown" {
  type        = number
  description = "Period (in seconds) to wait between scale down events"
  default     = 300
}
