variable "token" {}

variable "master_count" {
  default = 0
}

variable "worker_count" {
  default = 0
}

variable "master_hostname_format" {
  type = string
}

variable "worker_hostname_format" {
  type = string
}

variable "location" {
  type = string
}

variable "master_type" {
  type = string
}

variable "worker_type" {
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