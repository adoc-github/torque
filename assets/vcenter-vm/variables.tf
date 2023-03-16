variable "vsphere_server" {
  description = "vCenter server IP"
  default = "vcenter.example.com"
  type = string
}

variable "user_name" {
  description = "Username for vCenter server access"
  default = "user@example.com"
  type = string
}

variable "password" {
  description = "Password for vCenter server access"
  default = "password"
  type = string
}
