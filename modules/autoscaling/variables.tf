variable "name" {
  type        = string
  description = "ASG name."
}

variable "ami_id" {
  type        = string
  description = "AMI ID."
}

variable "instance_type" {
  type        = string
  description = "Instance type."
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups."
}

variable "iam_instance_profile_name" {
  type        = string
  description = "Instance profile name."
}

variable "key_name" {
  type        = string
  description = "Key pair name."
  default     = null
}

variable "root_device_name" {
  type        = string
  description = "Root device name."
  default     = "/dev/xvda"
}

variable "root_volume_kms_key_id" {
  type        = string
  description = "KMS key ID for volume encryption."
  default     = null
}

variable "root_volume_size" {
  type        = number
  description = "Root volume size in GB."
  default     = 30
}

variable "root_volume_type" {
  type        = string
  description = "Root volume type."
  default     = "gp3"
}

variable "user_data_base64" {
  type        = string
  description = "Base64 user data."
  default     = null
  sensitive   = true
}

variable "min_size" {
  type        = number
  description = "Minimum ASG size."
}

variable "max_size" {
  type        = number
  description = "Maximum ASG size."
}

variable "desired_capacity" {
  type        = number
  description = "Desired ASG capacity."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for ASG."
}

variable "health_check_type" {
  type        = string
  description = "Health check type."
  default     = "EC2"
}

variable "health_check_grace_period" {
  type        = number
  description = "Grace period in seconds."
  default     = 300
}

variable "target_group_arns" {
  type        = list(string)
  description = "ALB target groups."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
