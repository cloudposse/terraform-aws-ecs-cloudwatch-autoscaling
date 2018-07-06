
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attributes | List of attributes to add to label. | list | `<list>` | no |
| cluster_name | The name of the ECS cluster where service is to be autoscaled. | string | - | yes |
| delimiter | The delimiter to be used in labels. | string | `-` | no |
| enabled | Whether to create all resources | string | `true` | no |
| max_capacity | Maximum number of running instances of a Service. | string | `2` | no |
| min_capacity | Minimum number of running instances of a Service. | string | `1` | no |
| name | Name (unique identifier for app or service) | string | - | yes |
| namespace | Namespace (e.g. `cp` or `cloudposse`) | string | - | yes |
| scale_down_adjustment | Scaling adjustment to make during scale down event. | string | `-1` | no |
| scale_down_cooldown | Period (in seconds) to wait between scale down events. | string | `300` | no |
| scale_up_adjustment | Scaling adjustment to make during scale up event. | string | `1` | no |
| scale_up_cooldown | Period (in seconds) to wait between scale up events. | string | `60` | no |
| service_name | The name of the ECS Service to autoscale. | string | - | yes |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | - | yes |
| tags | Map of key-value pairs to use for tags. | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws_appautoscaling_policy_down_arn | ARN of the scale down policy. |
| aws_appautoscaling_policy_up_arn | ARN of the scale up policy. |

