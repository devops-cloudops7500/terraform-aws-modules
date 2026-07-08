variable "aws_region" {
  type        = string
  description = "AWS region for provider operations."

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]+$", var.aws_region))
    error_message = "aws_region must look like us-east-1."
  }
}

variable "environment" {
  type        = string
  description = "Deployment environment name."

  validation {
    condition     = contains(["dev", "qa", "uat", "staging", "prod"], lower(var.environment))
    error_message = "environment must be one of dev, qa, uat, staging, prod."
  }
}

variable "project_name" {
  type        = string
  description = "Project identifier used in naming and tags."

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,30}$", var.project_name))
    error_message = "project_name must be 3-31 chars, lowercase alphanumeric and hyphens, starting with a letter."
  }
}

variable "owner" {
  type        = string
  description = "Owning team name."

  validation {
    condition     = length(trimspace(var.owner)) > 1
    error_message = "owner must not be empty."
  }
}

variable "cost_center" {
  type        = string
  description = "Cost center or charge code."

  validation {
    condition     = length(trimspace(var.cost_center)) > 1
    error_message = "cost_center must not be empty."
  }
}

variable "data_classification" {
  type        = string
  description = "Data classification label for governance."
  default     = "internal"

  validation {
    condition     = contains(["public", "internal", "confidential", "restricted"], lower(var.data_classification))
    error_message = "data_classification must be one of public, internal, confidential, restricted."
  }
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to apply to all resources."
  default     = {}
}

variable "hcp_organization" {
  type        = string
  description = "HCP Terraform organization name."

  validation {
    condition     = length(trimspace(var.hcp_organization)) > 1
    error_message = "hcp_organization must not be empty."
  }
}

variable "hcp_workspace_name" {
  type        = string
  description = "HCP Terraform workspace name for this stack."

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-_]{2,63}$", var.hcp_workspace_name))
    error_message = "hcp_workspace_name must be 3-64 chars and use lowercase letters, numbers, hyphens, or underscores."
  }
}
