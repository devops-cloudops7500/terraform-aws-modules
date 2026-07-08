output "db_instance_identifier" {
  description = "DB identifier."
  value       = module.rds.db_instance_identifier
}

output "db_instance_endpoint" {
  description = "DB endpoint."
  value       = module.rds.db_instance_endpoint
}
