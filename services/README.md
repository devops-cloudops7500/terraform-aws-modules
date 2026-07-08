# Services Layer

Each service stack orchestrates one business domain by consuming reusable modules from ../../modules.

- network: VPC, subnets, route tables, NAT, IGW, EIP
- compute: EC2, security group, IAM role/profile, optional EIP
- storage: S3
- security: KMS and Secrets Manager
- data: RDS
- messaging: SNS and SQS
