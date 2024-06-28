# Yandex Cloud Managed Redis Terraform module

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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
| <a name="module_redis_sharded"></a> [redis\_sharded](#module\_redis\_sharded) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.private](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/vpc_network) | data source |
| [yandex_vpc_subnet.private](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/vpc_subnet) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The fully qualified domain name of the host |
| <a name="output_shard_name"></a> [shard\_name](#output\_shard\_name) | The name of the shard to which the host belongs |
| <a name="output_status"></a> [status](#output\_status) | Status of the cluster. Can be either CREATING, STARTING, RUNNING, UPDATING, STOPPING, STOPPED, ERROR or STATUS\_UNKNOWN |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
