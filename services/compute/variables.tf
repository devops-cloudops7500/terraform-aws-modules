variable "instance_role_name" {
  type        = string
  description = "IAM role name for EC2."
}

variable "instance_profile_name" {
  type        = string
  description = "IAM instance profile name."
}

variable "instance_role_policy_arns" {
  type        = list(string)
  description = "AWS managed policy ARNs for instance role."
  default     = []
}

variable "instance_role_custom_policies" {
  type = map(object({
    description = string
    policy_json = string
  }))
  description = "Custom policies for instance role."
  default     = {}
}

variable "security_group_name" {
  type        = string
  description = "Security group name."
}

variable "security_group_description" {
  type        = string
  description = "Security group description."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID."
}

variable "ingress_rules" {
  type = list(object({
    description      = optional(string)
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    prefix_list_ids  = optional(list(string), [])
    security_groups  = optional(list(string), [])
    self             = optional(bool, false)
  }))
  description = "Ingress rules."
  default     = []
}

variable "egress_rules" {
  type = list(object({
    description      = optional(string)
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    prefix_list_ids  = optional(list(string), [])
    security_groups  = optional(list(string), [])
    self             = optional(bool, false)
  }))
  description = "Egress rules."
  default = [
    {
      description      = "Allow all"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}

variable "instance_name" {
  type        = string
  description = "EC2 instance name."
}

variable "ami_id" {
  type        = string
  description = "AMI ID."
}

variable "instance_type" {
  type        = string
  description = "Instance type."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID."
}

variable "key_name" {
  type        = string
  description = "EC2 key pair."
  default     = null
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Assign public IP."
  default     = false
}

variable "attach_eip" {
  type        = bool
  description = "Attach Elastic IP to instance."
  default     = false
}

variable "user_data" {
  type        = string
  description = "User data script."
  default     = null
  sensitive   = true
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
  description = "KMS key for root volume encryption."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
  default     = {}
}
