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
  description = "Elastic IP name tag."
}

variable "instance_id" {
  type        = string
  description = "Optional EC2 instance ID for EIP association."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Resource-specific tags."
  default     = {}
}
