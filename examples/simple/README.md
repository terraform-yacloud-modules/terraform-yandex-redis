# Yandex Cloud Managed Redis Terraform module

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.47.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.47.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network"></a> [network](#module\_network) | git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git | v1.0.0 |
| <a name="module_redis_simple"></a> [redis\_simple](#module\_redis\_simple) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [yandex_client_config.client](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config"></a> [config](#output\_config) | Configuration of the Redis cluster |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Creation timestamp of the cluster |
| <a name="output_deletion_protection"></a> [deletion\_protection](#output\_deletion\_protection) | Inhibits deletion of the cluster |
| <a name="output_description"></a> [description](#output\_description) | Description of the Redis cluster |
| <a name="output_environment"></a> [environment](#output\_environment) | Deployment environment of the Redis cluster |
| <a name="output_folder_id"></a> [folder\_id](#output\_folder\_id) | ID of the folder that the resource belongs to |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The fully qualified domain name of the cluster |
| <a name="output_health"></a> [health](#output\_health) | Aggregated health of the cluster |
| <a name="output_hosts"></a> [hosts](#output\_hosts) | A list of hosts in the Redis cluster |
| <a name="output_id"></a> [id](#output\_id) | ID of the Redis cluster |
| <a name="output_labels"></a> [labels](#output\_labels) | A set of key/value label pairs to assign to the Redis cluster |
| <a name="output_maintenance_window"></a> [maintenance\_window](#output\_maintenance\_window) | Maintenance policy of the Redis cluster |
| <a name="output_name"></a> [name](#output\_name) | Name of the Redis cluster |
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | ID of the network to which the Redis cluster belongs |
| <a name="output_persistence_mode"></a> [persistence\_mode](#output\_persistence\_mode) | Persistence mode of the Redis cluster |
| <a name="output_resources"></a> [resources](#output\_resources) | Resources allocated to hosts of the Redis cluster |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | A set of ids of security groups assigned to hosts of the cluster |
| <a name="output_sharded"></a> [sharded](#output\_sharded) | Redis Cluster mode enabled/disabled |
| <a name="output_tls_enabled"></a> [tls\_enabled](#output\_tls\_enabled) | TLS support mode enabled/disabled |
<!-- END_TF_DOCS -->
