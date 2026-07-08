variable "name" {
  type        = string
  description = "ALB name."
}

variable "internal" {
  type        = bool
  description = "Whether the ALB is internal."
  default     = false
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs attached to ALB."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for ALB."
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Enable ALB deletion protection."
  default     = false
}

variable "idle_timeout" {
  type        = number
  description = "ALB idle timeout in seconds."
  default     = 60
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for target group."
}

variable "target_group_name" {
  type        = string
  description = "Target group name."
}

variable "target_group_port" {
  type        = number
  description = "Target group port."
  default     = 80
}

variable "target_group_protocol" {
  type        = string
  description = "Target group protocol."
  default     = "HTTP"
}

variable "target_type" {
  type        = string
  description = "Target type for target group."
  default     = "instance"
}

variable "listener_port" {
  type        = number
  description = "Listener port."
  default     = 80
}

variable "listener_protocol" {
  type        = string
  description = "Listener protocol."
  default     = "HTTP"
}

variable "health_check" {
  type = object({
    enabled             = optional(bool, true)
    interval            = optional(number, 30)
    path                = optional(string, "/")
    healthy_threshold   = optional(number, 3)
    unhealthy_threshold = optional(number, 3)
    timeout             = optional(number, 5)
    matcher             = optional(string, "200")
    protocol            = optional(string, "HTTP")
  })
  description = "Target group health check settings."
  default     = {}
}

variable "target_instance_ids" {
  type        = list(string)
  description = "Optional EC2 instance IDs to register with target group."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to ALB resources."
  default     = {}
}
