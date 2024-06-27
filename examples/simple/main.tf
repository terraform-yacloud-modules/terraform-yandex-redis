module "redis" {
  source = "../../"

  folder_id   = "xxxx"
  name        = "test-redis"
  subnet_id   = "xxxx"
  network_id  = "xxxx"
  password    = "xxxx"
}
