variable "name" {
  type        = string
  description = "Security group name."
}

variable "description" {
  type        = string
  description = "Security group description."
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  type        = string
  description = "Target VPC ID."
}

variable "ingress_rules" {
  type = list(object({
    ip_protocol = string
    from_port   = optional(number)
    to_port     = optional(number)
    cidr_ipv4   = optional(string)
    cidr_ipv6   = optional(string)
    description = optional(string)
  }))
  description = "List of ingress rules."
  default     = []
}

variable "egress_rules" {
  type = list(object({
    ip_protocol = string
    from_port   = optional(number)
    to_port     = optional(number)
    cidr_ipv4   = optional(string)
    cidr_ipv6   = optional(string)
    description = optional(string)
  }))
  description = "List of egress rules."
  default = [
    {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all outbound IPv4 traffic"
    }
  ]
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the security group."
  default     = {}
}
