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
}

variable "tags" {
  type        = map(string)
  description = "Resource-specific tags."
  default     = {}
}
