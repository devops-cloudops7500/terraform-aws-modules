variable "name" {
  type        = string
  description = "VPC name."
}

variable "cidr_block" {
  type        = string
  description = "Primary VPC CIDR block."
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support in the VPC."
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in the VPC."
  default     = true
}

variable "create_internet_gateway" {
  type        = bool
  description = "Whether to create an internet gateway for the VPC."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to VPC resources."
  default     = {}
}
