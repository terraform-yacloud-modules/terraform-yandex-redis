# Wrapper module

This `wrappers` introduces a wrapper module pattern that enables bulk creation of multiple Redis clusters with shared default configurations. The wrapper uses Terraform's `for_each`
meta-argument to instantiate the main Redis module multiple times, with defaults that can be overridden per-cluster.

## Examples

Terragrunt wrapper module usage example:

```hcl
terraform {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-redis.git//wrappers?ref=v1.0.0"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  folder_vars = read_terragrunt_config(find_in_parent_folders("folder.hcl"))

  environment   = local.folder_vars.locals.environment
  common_labels = local.folder_vars.locals.labels
  custom_labels = {
    component = "redis"
  }
}

dependency "vpc" {
  config_path = "${find_in_parent_folders("vpc")}"
}

inputs = {
  defaults = {
    network_id          = dependency.vpc.outputs.vpc_id
    tls_enabled         = false
    assign_public_ip    = false
    redis_version       = "8.1-valkey"
    maxmemory_policy    = "VOLATILE_LRU"
    resource_preset_id  = "b3-c1-m4"
    disk_type_id        = "network-ssd"
    disk_size           = 16
    deletion_protection = true
    label               = merge(local.common_labels, local.custom_labels)
  }

  items = {
    cache = {
      name                      = "cache"
      description               = "Cache without sync to disk"
      persistence_mode          = "OFF"
      password                  = "DontUseInProduction"

      hosts = {
        host1 = {
          zone             = "ru-central1-a"
          subnet_id        = dependency.vpc.outputs.private_subnets_ids[0]
          replica_priority = 100
        }
        host2 = {
          zone             = "ru-central1-b"
          subnet_id        = dependency.vpc.outputs.private_subnets_ids[1]
          replica_priority = 10
        }
      }

      labels = merge(local.common_labels, local.custom_labels, {
        part-of = "application"
      })
    }

    sessions = {
      name                      = "sessions"
      description               = "Sessions with sync to disk"
      disk_size                 = 93
      persistence_mode          = "ON"
      password                  = "DontUseInProduction"
      maxmemory_policy          = "NOEVICTION"

      backup_window_start = {
        hours = 22
      }

      hosts = {
        host1 = {
          zone             = "ru-central1-a"
          subnet_id        = dependency.vpc.outputs.private_subnets_ids[1]
          replica_priority = 90
        }
        host2 = {
          zone             = "ru-central1-b"
          subnet_id        = dependency.vpc.outputs.private_subnets_ids[0]
          replica_priority = 10
        }
      }
      disk_type_id        = "network-ssd-io-m3"
      resource_preset_id  = "hm3-c2-m8"

      labels = merge(local.common_labels, local.custom_labels, {
        part-of   = "application"
      })
    }
  }
}

```
