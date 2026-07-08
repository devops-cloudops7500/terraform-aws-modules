variable "name" {
  type        = string
  description = "ALB name."
}

variable "internal" {
  type        = bool
  description = "Internal ALB when true."
  default     = true
}

variable "security_group_ids" {
  type        = list(string)
  description = "ALB security groups."
}

variable "subnet_ids" {
  type        = list(string)
  description = "ALB subnet IDs."
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Enable ALB deletion protection."
  default     = true
}

variable "idle_timeout" {
  type        = number
  description = "ALB idle timeout."
  default     = 60
}

variable "target_groups" {
  type = map(object({
    port                  = number
    protocol              = string
    target_type           = string
    vpc_id                = string
    health_check_path     = string
    health_check_matcher  = string
    health_check_interval = number
    health_check_timeout  = number
    healthy_threshold     = number
    unhealthy_threshold   = number
  }))
  description = "Target group definitions."
}

variable "listeners" {
  type = map(object({
    port             = number
    protocol         = string
    ssl_policy       = optional(string)
    certificate_arn  = optional(string)
    target_group_key = string
  }))
  description = "Listener definitions."
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
