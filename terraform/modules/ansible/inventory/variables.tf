variable "inventory_path" {
  type = string
}

variable "primary_hostnames" {
  type = list(string)
}

variable "primary_public_ips" {
  type = map(string)
}

variable "primary_private_ips" {
  type = map(string)
}

variable "secondary_hostnames" {
  type = list(string)
}

variable "secondary_public_ips" {
  type = map(string)
}

variable "secondary_private_ips" {
  type = map(string)
}