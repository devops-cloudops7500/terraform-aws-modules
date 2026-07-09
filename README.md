# Terraform AWS Services Framework (Production-Ready)

This repository implements multiple AWS infrastructure services using reusable modules and thin service orchestration layers.

## Repository Structure

```text
TF/
├── modules/
│   ├── s3/
│   ├── vpc/
│   ├── subnet/
│   ├── security-group/
│   ├── ec2/
│   ├── alb/
│   └── public-ip/
├── services/
│   ├── s3/
│   ├── vpc/
│   ├── subnet/
│   ├── security-group/
│   ├── ec2/
│   ├── alb/
│   └── public-ip/
├── .github/
│   └── workflows/
│       ├── aws-destroy.yml
│       └── aws-deploy.yml
├── .gitignore
└── README.md
```

## Architecture

- `modules/*` contains reusable resource definitions.
- `services/*` calls modules and contains no direct resource blocks.
- Environment-specific input values live in a separate repository.

Supported services:

- `s3`
- `vpc`
- `subnet`
- `security-group`
- `ec2`
- `alb`
- `public-ip`

## Separate Environment Repository

Store environment values in another repo, for example:

```text
project-a-infra/
├── dev/
│   ├── s3/
│   │   └── terraform.tfvars
│   ├── vpc/
│   │   └── terraform.tfvars
│   └── ...
├── test/
│   ├── s3/
│   │   └── terraform.tfvars
│   ├── vpc/
│   │   └── terraform.tfvars
│   └── ...
└── prod/
  ├── s3/
  │   └── terraform.tfvars
  ├── vpc/
  │   └── terraform.tfvars
  └── ...
```

This Terraform repository must not contain environment-specific values.

## GitHub Actions Deployment Flow

Workflow (Deploy): `.github/workflows/aws-deploy.yml`

Workflow (Destroy): `.github/workflows/aws-destroy.yml`

1. Checkout this reusable Terraform repository.
2. Checkout the input-values repository.
3. Resolve the selected service path and the matching tfvars file at `<tfvars_root>/<environment>/<service>/terraform.tfvars`.
4. Run `terraform fmt`.
5. Generate HCP backend config using organization and service-specific workspace.
6. Run `terraform init` with HCP backend config.
7. Run `terraform validate`.
8. Run `terraform plan` with the selected service tfvars.
9. Run `terraform apply`.
10. Production approval is handled by GitHub Environment protection (`production`).

## HCP Terraform Setup (Step by Step)

1. Create HCP Terraform organization
- Sign in to app.terraform.io.
- Create organization, for example `acme-platform`.

2. Create workspaces
- Create one workspace per environment-service.
- Naming pattern: `<project>-<env>-<service>`
- Examples:
  - `project-a-dev-s3`
  - `project-a-dev-vpc`
  - `project-a-dev-subnet`
  - `project-a-dev-security-group`
  - `project-a-dev-ec2`
  - `project-a-dev-alb`
  - `project-a-dev-public-ip`

3. Configure backend in workflow
- The workflow generates `cloud.auto.tf` at runtime with:
  - `organization = <HCP_ORGANIZATION>`
  - `workspaces { name = <PROJECT_NAME-environment-service> }`

4. Configure backend at runtime (init)
- `terraform init -backend-config="organization=<org>" -backend-config="workspaces.name=<workspace>"`

5. Authenticate GitHub Actions to HCP Terraform
- Add repository secret:
  - `TF_API_TOKEN`
- Exported as:
  - `TF_TOKEN_app_terraform_io`

6. Store remote state and locking
- HCP Terraform backend stores state remotely and provides native locking automatically.

7. Manage separate workspaces
- Use workflow input `environment` to target `dev`, `test`, or `prod`.
- Use workflow input `service` to target a stack such as `s3`, `vpc`, or `ec2`.
- Workspace name is generated in workflow as `${PROJECT_NAME}-${environment}-${service}`.

## Required GitHub Secrets and Variables

Secrets:

- `TF_API_TOKEN`
- `AWS_DEPLOY_ROLE_ARN`
- `INPUTS_REPO_TOKEN` (required if input repo is private)

Variables:

- `HCP_ORGANIZATION`
- `AWS_REGION`
- `PROJECT_NAME`
- `OWNER`
- `COST_CENTER`
- `DATA_CLASSIFICATION`

## Service Usage Example

Each service directory under `services/` calls its matching module under `modules/`.

You select the `service` input in workflow dispatch, and deployment uses the matching environment and service tfvars file from the separate repo:

- `dev/s3/terraform.tfvars`
- `dev/vpc/terraform.tfvars`
- `test/ec2/terraform.tfvars`
- `prod/alb/terraform.tfvars`

## Example tfvars (in separate repo)

```hcl
aws_region          = "us-east-1"
environment         = "dev"
project_name        = "project-a"
owner               = "platform-team"
cost_center         = "cc-1001"
data_classification = "internal"

bucket_name             = "project-a-dev-artifacts-001"
versioning_enabled      = true
block_public_access     = true
object_ownership        = "BucketOwnerEnforced"
allow_tls_requests_only = true
enable_access_logging   = false

lifecycle_rules = []
cors_rules      = []

tags = {
  Application = "project-a"
  Service     = "s3"
}
```

## Security Recommendations

- Keep public access blocked by default.
- Enforce TLS-only requests.
- Enable versioning for recovery and auditability.
- Prefer SSE-KMS for compliance workloads.
- Enable access logging to a centralized log bucket.
- Do not store secrets in code or tfvars tracked in source control.
- Use OIDC for AWS authentication in GitHub Actions.

## Best Practices

- Pin Terraform and provider versions.
- Keep module reusable and input-driven.
- Keep service layer thin and orchestration-only.
- Use one workspace per environment-service.
- Promote changes via pull requests and environment approvals.
