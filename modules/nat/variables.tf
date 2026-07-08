variable "name" {
  type        = string
  description = "NAT gateway name tag."
}

variable "allocation_id" {
  type        = string
  description = "Elastic IP allocation ID."
}

variable "subnet_id" {
  type        = string
  description = "Public subnet ID where NAT gateway is created."
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
