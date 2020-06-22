variable "token" {
  type    = string
  default = ""
}

variable "primary_count" {
  default = 0
}

variable "secondary_count" {
  default = 0
}

variable "primary_hostname_format" {
  type = string
}

variable "secondary_hostname_format" {
  type = string
}

variable "location" {
  type = string
}

variable "primary_type" {
  type = string
}

variable "secondary_type" {
  type = string
}

variable "image" {
  type = string
}

variable "ssh_keys" {
  type = list(string)
}

variable "apt_packages" {
  type    = list(string)
  default = []
}

variable "ip_range" {
  type = string
}

variable "subnet_ip_range" {
  type = string
}