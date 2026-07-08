variable "name" {
  type        = string
  description = "VPC name tag."

  validation {
    condition     = length(trimspace(var.name)) > 2
    error_message = "name must not be empty."
  }
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for VPC."

  validation {
    condition     = can(cidrhost(var.cidr_block, 0))
    error_message = "cidr_block must be valid CIDR."
  }
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support in VPC."
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC."
  default     = true
}

variable "instance_tenancy" {
  type        = string
  description = "Tenancy option for instances launched in VPC."
  default     = "default"

  validation {
    condition     = contains(["default", "dedicated"], var.instance_tenancy)
    error_message = "instance_tenancy must be default or dedicated."
  }
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
