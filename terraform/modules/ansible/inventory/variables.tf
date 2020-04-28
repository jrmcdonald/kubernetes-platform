variable "inventory_path" {
  type = string
}

variable "master_hostnames" {
  type = list(string)
}

variable "master_public_ips" {
  type = map(string)
}

variable "master_private_ips" {
  type = map(string)
}

variable "worker_hostnames" {
  type = list(string)
}

variable "worker_public_ips" {
  type = map(string)
}

variable "worker_private_ips" {
  type = map(string)
}