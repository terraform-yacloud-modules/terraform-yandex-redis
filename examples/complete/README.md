# Полный пример кластера Yandex Managed Redis

Пример создаёт кластер Managed Redis со всеми основными возможностями модуля:

- два хоста в зонах `ru-central1-a` и `ru-central1-d`;
- собственная сеть VPC и security group для доступа к Redis по порту 6379;
- ежедневные резервные копии с окном запуска и сроком хранения
  (`backup_window_start`, `backup_retain_period_days`);
- автоматическое расширение диска (`disk_size_autoscaling`);
- доступ из DataLens и веб-интерфейса SQL (`access`);
- расширенные ACL-пользователи: включённые и отключённые, с ограничениями
  по командам, ключам, базам данных и Pub/Sub-каналам;
- обслуживание по расписанию (`type`, `hour`, `day`) и таймауты операций.

## Запуск

```bash
terraform init
terraform plan
terraform apply
```

`folder_id` задаётся в `terraform.tfvars` (или передаётся через переменную
`-var folder_id=...` / Terragrunt). Если он не указан, используется каталог
провайдера.

Пример создаёт платные ресурсы. После проверки выполните:

```bash
terraform destroy
```

## Новые параметры

| Параметр | Где используется | Назначение |
| --- | --- | --- |
| `backup_retain_period_days` | `module.redis_complete` | Срок хранения автоматических резервных копий в днях |
| `users[*].enabled` | `module.redis_complete` | Включение и отключение ACL-пользователя |
| `users[*].permissions_databases` | `module.redis_complete` | Доступные пользователю базы данных (`alldbs`, `resetdbs` или список номеров) |
| `users[*].permissions_pub_sub_channels` | `module.redis_complete` | Разрешённые Pub/Sub-каналы пользователя |

Чтобы использовать `permissions_databases`, в примере выбран Valkey `9.1-valkey`:
Yandex Cloud разрешает ACL на уровне баз данных только начиная с Valkey 9.1.
