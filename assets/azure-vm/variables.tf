variable "admin_username" {
  description = "Username for azure vm access"
  default = "adminuser"
  type = string
}

variable "admin_password" {
  description = "Password for vCenter vm access"
  default = "password"
  type = string
}
