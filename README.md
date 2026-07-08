# Terraform S3 Framework (Production-Ready)

This repository implements only S3 infrastructure using a reusable module and a service orchestration layer.

## Repository Structure

```text
TF/
├── modules/
│   └── s3/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── versions.tf
│       └── README.md
├── services/
│   └── s3/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── .github/
│   └── workflows/
│       └── s3-deploy.yml
├── .gitignore
└── README.md
```

## Architecture

- `modules/s3` contains all resource configuration.
- `services/s3` calls the module and contains no direct resource blocks.
- Environment-specific input values live in a separate repository.

## Separate Environment Repository

Store environment values in another repo, for example:

```text
project-a-infra/
├── dev/
│   └── terraform.tfvars
├── test/
│   └── terraform.tfvars
└── prod/
    └── terraform.tfvars
```

This Terraform repository must not contain environment-specific values.

## GitHub Actions Deployment Flow

Workflow: `.github/workflows/s3-deploy.yml`

1. Checkout this reusable Terraform repository.
2. Checkout the input-values repository.
3. Resolve environment tfvars path.
4. Run `terraform fmt`.
5. Run `terraform init` with HCP backend config.
6. Run `terraform validate`.
7. Run `terraform plan` with environment tfvars.
8. Run `terraform apply`.
9. Production approval is handled by GitHub Environment protection (`production`).

## HCP Terraform Setup (Step by Step)

1. Create HCP Terraform organization
- Sign in to app.terraform.io.
- Create organization, for example `acme-platform`.

2. Create workspaces
- Create one workspace per environment-resource.
- Naming pattern: `<project>-<env>-s3`
- Examples:
  - `project-a-dev-s3`
  - `project-a-test-s3`
  - `project-a-prod-s3`

3. Configure backend in code
- `services/s3/main.tf` includes:
  - `terraform { backend "remote" {} }`

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
- Workspace name is generated in workflow as `${PROJECT_NAME}-${environment}-s3`.

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

`services/s3` automatically calls `modules/s3`. Deployment uses the environment tfvars file from the separate repo:

- `dev/terraform.tfvars`
- `test/terraform.tfvars`
- `prod/terraform.tfvars`

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
- Use one workspace per environment-resource.
- Promote changes via pull requests and environment approvals.
