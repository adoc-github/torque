variable "ami" {
  description = "ami id"
  default = "ami-3185744e"
  type = string
}

variable "instance_type" {
  description = "Instance type"
  default = "t2.micro"
  type = string

  validation {
    condition = contains(["t1.micro", "t2.micro"], lower(var.instance_type))
    error_message = "Instance Type not recognized. Options: t1.micro, t2.micro"
  }
}
