output "fqdn_redis" {
  value = "c-${yandex_mdb_redis_cluster.this.id}.rw.mdb.yandexcloud.net"
}
