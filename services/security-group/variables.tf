variable "aws_region" {
  type        = string
  description = "AWS region for deployment."
}

variable "environment" {
  type        = string
  description = "Environment name."

  validation {
    condition     = contains(["dev", "test", "prod"], lower(var.environment))
    error_message = "environment must be one of dev, test, prod."
  }
}

variable "project_name" {
  type        = string
  description = "Project identifier."
}

variable "owner" {
  type        = string
  description = "Owning team."
}

variable "cost_center" {
  type        = string
  description = "Cost center code."
}

variable "data_classification" {
  type        = string
  description = "Data classification label."
  default     = "internal"
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional default tags."
  default     = {}
}

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
  description = "Resource-specific tags."
  default     = {}
}
