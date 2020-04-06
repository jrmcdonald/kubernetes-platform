/* general */
variable "domain" {
  default = "qwyck-cloud.co.uk"
}

/* hcloud */
variable "hcloud_token" {
  default = ""
}

variable "hcloud_ssh_keys" {
  type    = list(string)
  default = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC4axeFdRYAXCX/KOJFW20srLLvGRmMCw0yJHbRLUuV3kXEYGyxPRjXhyVx5n4UBGPBNW4nAqoVeMCubzojvgFfagQRENM5E6NvKI2/wP+mETZRyWi3Aff2vXjbkd0Jpxnbo28KFrPNClaKR6BsrnnQsr36YhUUsSnyoeLms7QLpsmPSJFFs/X4g5OZqCDJ9Ey9WHP4AFFjD7t64yr/IDnfpXZpsmEX7HChhMSQKVxpteFMBDvJL55RfpurlyS/+AqEMLqgZ4pseY/+LnsnZaQQcOchuC8tXDzsGa7S7Mnc23udvODharvrVxKR3UWKArcdGEYked6XKkIHrzFACnugZV9ajp9M+urRS4C8B7h25bxOXs+ZdHAIcotfVwcxhnWoczhDXbSlML8RCmGefCKWFYIr5FFeS1ikkbYBNw1IrzpEX/uHFIhtfH0ubKiwnLHS21jn8tU773Dx3mNyxke9G/nSPfGq+4VBn3g5wNuwbxGEMa2jYgvi8UO0QOPf8fLqKwqeAZqJuZyyCnVkejk1UOYJ6yMhYmSjhFIoawAChhqQpAwjZaEqrslJx+d/y6U6sTGJLr0JgEC2mKNNXki7m/lV3QToCSCz87XDjmiAzA4yoXu28/mEuvfL+wtEqR9Nbf+Gm+EWo8ohy6hI22tLMfqYpkC/sDkMYPlg2Yy6AQ=="]
}

/* cloudflare dns */
variable "cloudflare_email" {
  default = "jamie.mcdonald@qwyck.net"
}

variable "cloudflare_api_token" {
  default = ""
}