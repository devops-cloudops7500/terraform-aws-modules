variable "name" {
  type        = string
  description = "Elastic IP name tag."
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
