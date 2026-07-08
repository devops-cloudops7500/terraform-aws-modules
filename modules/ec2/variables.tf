variable "name" {
  type        = string
  description = "EC2 instance name tag."
}

variable "ami_id" {
  type        = string
  description = "AMI ID for instance."
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID."
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs."
}

variable "iam_instance_profile" {
  type        = string
  description = "IAM instance profile name."
  default     = null
}

variable "key_name" {
  type        = string
  description = "SSH key pair name."
  default     = null
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Assign public IP."
  default     = false
}

variable "user_data" {
  type        = string
  description = "Cloud-init/userdata script."
  default     = null
  sensitive   = true
}

variable "user_data_replace_on_change" {
  type        = bool
  description = "Force replacement on user_data change."
  default     = true
}

variable "enable_detailed_monitoring" {
  type        = bool
  description = "Enable detailed monitoring."
  default     = true
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

variable "root_volume_kms_key_id" {
  type        = string
  description = "Optional KMS key for root volume."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
