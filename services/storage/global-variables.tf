variable "aws_region" {
  type        = string
  description = "AWS region for provider operations."
}

variable "environment" {
  type        = string
  description = "Deployment environment."

  validation {
    condition     = contains(["dev", "qa", "uat", "staging", "prod"], lower(var.environment))
    error_message = "environment must be one of dev, qa, uat, staging, prod."
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

variable "service_name" {
  type        = string
  description = "Logical service name."
}

variable "hcp_organization" {
  type        = string
  description = "HCP Terraform organization."
}

variable "hcp_workspace_name" {
  type        = string
  description = "HCP Terraform workspace name."
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional default tags."
  default     = {}
}
