variable "vpc_name" {
  type        = string
  description = "VPC name."
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block."
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC."
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support in VPC."
  default     = true
}

variable "public_subnets" {
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
  description = "Public subnet definitions."
}

variable "private_subnets" {
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
  description = "Private subnet definitions."
}

variable "tags" {
  type        = map(string)
  description = "Tags for all network resources."
  default     = {}
}
