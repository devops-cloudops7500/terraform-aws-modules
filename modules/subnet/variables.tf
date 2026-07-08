variable "name" {
  type        = string
  description = "Subnet name tag."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where subnet is created."
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for subnet."

  validation {
    condition     = can(cidrhost(var.cidr_block, 0))
    error_message = "cidr_block must be valid CIDR."
  }
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for subnet."
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Whether to auto-assign public IPv4."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
