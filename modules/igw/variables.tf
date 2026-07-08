variable "name" {
  type        = string
  description = "Internet gateway name tag."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to attach IGW."
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
