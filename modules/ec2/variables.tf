variable "name" {
  type        = string
  description = "EC2 instance name."
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use for the instance."
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the instance is launched."
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs attached to the instance."
  default     = []
}

variable "key_name" {
  type        = string
  description = "Optional key pair name."
  default     = null
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Assign a public IP on launch."
  default     = false
}

variable "iam_instance_profile" {
  type        = string
  description = "Optional IAM instance profile name."
  default     = null
}

variable "user_data" {
  type        = string
  description = "Optional user data script."
  default     = null
}

variable "root_block_device" {
  type = object({
    volume_type           = optional(string)
    volume_size           = optional(number)
    encrypted             = optional(bool)
    delete_on_termination = optional(bool)
    kms_key_id            = optional(string)
  })
  description = "Optional root block device override."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the instance."
  default     = {}
}
