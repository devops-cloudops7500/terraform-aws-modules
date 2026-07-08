variable "vpc_id" {
  type        = string
  description = "Target VPC ID."
}

variable "subnets" {
  type = list(object({
    name                    = string
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = optional(bool, false)
    tags                    = optional(map(string), {})
  }))
  description = "List of subnet definitions."

  validation {
    condition     = length(var.subnets) > 0
    error_message = "subnets must include at least one subnet definition."
  }
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to all subnets."
  default     = {}
}
