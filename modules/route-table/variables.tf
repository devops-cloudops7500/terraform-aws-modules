variable "name" {
  type        = string
  description = "Route table name tag."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for route table."
}

variable "routes" {
  type = list(object({
    cidr_block                = optional(string)
    ipv6_cidr_block           = optional(string)
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    transit_gateway_id        = optional(string)
    egress_only_gateway_id    = optional(string)
    network_interface_id      = optional(string)
    vpc_peering_connection_id = optional(string)
  }))
  description = "List of route definitions."
  default     = []
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets associated with route table."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
