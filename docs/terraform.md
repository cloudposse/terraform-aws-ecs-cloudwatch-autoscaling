## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attributes | Additional attributes (_e.g._ "1") | list(string) | `<list>` | no |
| cluster_name | The name of the ECS cluster where service is to be autoscaled | string | - | yes |
| delimiter | Delimiter between `namespace`, `stage`, `name` and `attributes` | string | `-` | no |
| enabled | Enable/disable resources creation | bool | `true` | no |
| max_capacity | Maximum number of running instances of a Service | number | `2` | no |
| min_capacity | Minimum number of running instances of a Service | number | `1` | no |
| name | Name of the application | string | - | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | string | `` | no |
| scale_down_adjustment | Scaling adjustment to make during scale down event | number | `-1` | no |
| scale_down_cooldown | Period (in seconds) to wait between scale down events | number | `300` | no |
| scale_up_adjustment | Scaling adjustment to make during scale up event | number | `1` | no |
| scale_up_cooldown | Period (in seconds) to wait between scale up events | number | `60` | no |
| service_name | The name of the ECS Service to autoscale | string | - | yes |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | `` | no |
| tags | Additional tags (_e.g._ { BusinessUnit : ABC }) | map(string) | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| scale_down_policy_arn | ARN of the scale down policy |
| scale_up_policy_arn | ARN of the scale up policy |

