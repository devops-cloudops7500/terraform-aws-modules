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
  description = "Tags applied to Elastic IP resources."
  default     = {}
}
