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
  description = "Whether to create an internet gateway."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Resource-specific tags."
  default     = {}
}
