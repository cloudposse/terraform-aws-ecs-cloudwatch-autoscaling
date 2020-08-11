## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0, < 0.14.0 |
| aws | ~> 2.0 |
| local | ~> 1.2 |
| null | ~> 2.0 |
| template | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attributes | Additional attributes (\_e.g.\_ "1") | `list(string)` | `[]` | no |
| cluster\_name | The name of the ECS cluster where service is to be autoscaled | `string` | n/a | yes |
| delimiter | Delimiter between `namespace`, `stage`, `name` and `attributes` | `string` | `"-"` | no |
| enabled | Enable/disable resources creation | `bool` | `true` | no |
| max\_capacity | Maximum number of running instances of a Service | `number` | `2` | no |
| min\_capacity | Minimum number of running instances of a Service | `number` | `1` | no |
| name | Name of the application | `string` | n/a | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | `string` | `""` | no |
| scale\_down\_adjustment | Scaling adjustment to make during scale down event | `number` | `-1` | no |
| scale\_down\_cooldown | Period (in seconds) to wait between scale down events | `number` | `300` | no |
| scale\_up\_adjustment | Scaling adjustment to make during scale up event | `number` | `1` | no |
| scale\_up\_cooldown | Period (in seconds) to wait between scale up events | `number` | `60` | no |
| service\_name | The name of the ECS Service to autoscale | `string` | n/a | yes |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | `string` | `""` | no |
| tags | Additional tags (\_e.g.\_ { BusinessUnit : ABC }) | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| scale\_down\_policy\_arn | ARN of the scale down policy |
| scale\_up\_policy\_arn | ARN of the scale up policy |

