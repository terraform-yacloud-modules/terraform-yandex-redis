variable "defaults" {
  description = "Map of default values which will be used for each item."
  type        = any
  default     = {}
}

variable "items" {
  description = "Maps of items to create a wrapper from.  Each item must include 'name', 'network_id', 'password', and 'hosts'. Values are passed through to the module"
  type        = any
  default     = {}
}
