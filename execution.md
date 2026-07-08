# AWS Services Deployment Execution Guide

This document explains how to authenticate GitHub Actions with AWS and HCP Terraform, configure repository secrets and variables, and run service-specific deployment workflows end to end.

## 1. Prerequisites

Before running the workflow, make sure you have:

- The Terraform repository with reusable modules and service layers (`s3`, `vpc`, `subnet`, `security-group`, `ec2`, `alb`, `public-ip`).
- A separate repository containing environment-specific `terraform.tfvars` files.
- An AWS account where the selected service resources will be created.
- An HCP Terraform organization and workspaces.
- Access to configure GitHub repository secrets, variables, and environments.

## 2. Files Used in This Repository

- Workflow: `.github/workflows/s3-deploy.yml`
- Service layers: `services/<service>/main.tf`
- Service variables: `services/<service>/variables.tf`
- Reusable modules: `modules/<service>/main.tf`
- Module variables: `modules/<service>/variables.tf`

## 3. Separate Input Repository Structure

Your separate inputs repository should look like this:

```text
project-a-infra-inputs/
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

The workflow reads tfvars from this path pattern:

```text
<tfvars_root>/<environment>/<service>/terraform.tfvars
```

Example:

```text
./dev/s3/terraform.tfvars
./test/ec2/terraform.tfvars
./prod/alb/terraform.tfvars
```

## 4. GitHub Secrets and Variables

### 4.1 GitHub Secrets

Add these under GitHub repository Settings > Secrets and variables > Actions > Secrets.

1. `TF_API_TOKEN`
- Purpose: HCP Terraform authentication.
- Used by workflow as:
  - `TF_TOKEN_app_terraform_io: ${{ secrets.TF_API_TOKEN }}`

2. `AWS_DEPLOY_ROLE_ARN`
- Purpose: IAM role ARN assumed by GitHub Actions using OIDC.
- Used by workflow as:
  - `role-to-assume: ${{ secrets.AWS_DEPLOY_ROLE_ARN }}`

3. `INPUTS_REPO_TOKEN`
- Purpose: Token for checking out the separate tfvars repository.
- Required when the inputs repo is private.
- Used by workflow as:
  - `token: ${{ secrets.INPUTS_REPO_TOKEN }}`

### 4.2 GitHub Variables

Add these under GitHub repository Settings > Secrets and variables > Actions > Variables.

1. `HCP_ORGANIZATION`
- Your HCP Terraform organization name.

2. `PROJECT_NAME`
- Used to build the workspace name.
- Example:
  - `project-a`

3. `AWS_REGION`
- AWS deployment region.
- Example:
  - `us-east-1`

4. `OWNER`
- Team or owner tag value.
- Example:
  - `platform-team`

5. `COST_CENTER`
- Cost center tag value.
- Example:
  - `cc-1001`

6. `DATA_CLASSIFICATION`
- Data classification tag value.
- Example:
  - `internal`
  - `confidential`

### 4.3 Workflow Runtime Inputs

These are selected when manually running the workflow:

1. `service`
- Choices:
  - `s3`
  - `vpc`
  - `subnet`
  - `security-group`
  - `ec2`
  - `alb`
  - `public-ip`

2. `environment`
- Choices:
  - `dev`
  - `test`
  - `prod`

3. `tfvars_repository`
- Example:
  - `nishu-kumar7500/project-1`

4. `tfvars_ref`
- Example:
  - `main`

5. `tfvars_root`
- Example:
  - `.`

## 5. Understanding These Workflow Environment Variables

These lines appear in the workflow:

```yaml
TF_TOKEN_app_terraform_io: ${{ secrets.TF_API_TOKEN }}
TF_WORKSPACE: ${{ vars.PROJECT_NAME }}-${{ github.event.inputs.environment }}-${{ github.event.inputs.service }}
TF_VAR_aws_region: ${{ vars.AWS_REGION }}
TF_VAR_environment: ${{ github.event.inputs.environment }}
TF_VAR_project_name: ${{ vars.PROJECT_NAME }}
TF_VAR_owner: ${{ vars.OWNER }}
TF_VAR_cost_center: ${{ vars.COST_CENTER }}
TF_VAR_data_classification: ${{ vars.DATA_CLASSIFICATION }}
```

Meaning:

1. `TF_TOKEN_app_terraform_io`
- Secret for HCP Terraform API authentication.

2. `TF_WORKSPACE`
- Computed workspace name.
- Example:
  - `project-a-dev-s3`
  - `project-a-dev-vpc`
  - `project-a-prod-ec2`

3. `TF_VAR_aws_region`
- Passes value to Terraform variable `aws_region`.

4. `TF_VAR_environment`
- Passes selected environment to Terraform variable `environment`.

5. `TF_VAR_project_name`
- Passes GitHub variable `PROJECT_NAME` to Terraform variable `project_name`.

6. `TF_VAR_owner`
- Passes GitHub variable `OWNER` to Terraform variable `owner`.

7. `TF_VAR_cost_center`
- Passes GitHub variable `COST_CENTER` to Terraform variable `cost_center`.

8. `TF_VAR_data_classification`
- Passes GitHub variable `DATA_CLASSIFICATION` to Terraform variable `data_classification`.

## 6. AWS Authentication from GitHub Actions Using OIDC

### 6.1 Create AWS OIDC Provider

In AWS Console:

1. Open IAM.
2. Go to Identity providers.
3. Click Add provider.
4. Provider type: `OpenID Connect`
5. Provider URL:

```text
https://token.actions.githubusercontent.com
```

6. Audience:

```text
sts.amazonaws.com
```

7. Save.

### 6.2 Create IAM Role for GitHub Actions

In AWS Console:

1. Go to IAM > Roles > Create role.
2. Choose `Web identity`.
3. Identity provider:
   - `token.actions.githubusercontent.com`
4. Audience:
   - `sts.amazonaws.com`
5. Create role with a name like:

```text
gh-terraform-s3-deploy
```

### 6.3 Trust Policy Example

Use a trust policy like this, replacing `YOUR_GITHUB_ORG` and `YOUR_TERRAFORM_REPO`:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::<AWS_ACCOUNT_ID>:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:YOUR_GITHUB_ORG/YOUR_TERRAFORM_REPO:*"
        }
      }
    }
  ]
}
```

This ensures only your GitHub repository can assume the role.

### 6.4 Add AWS Role ARN to GitHub Secret

Add the created role ARN to GitHub Secrets as:

```text
AWS_DEPLOY_ROLE_ARN
```

## 7. AWS Permissions for S3 Deployment

Attach a least-privilege IAM policy to the GitHub deployment role.

At minimum, allow actions required by the S3 module, such as:

- `s3:CreateBucket`
- `s3:DeleteBucket`
- `s3:GetBucket*`
- `s3:PutBucketPolicy`
- `s3:DeleteBucketPolicy`
- `s3:PutBucketVersioning`
- `s3:PutBucketPublicAccessBlock`
- `s3:PutBucketOwnershipControls`
- `s3:PutEncryptionConfiguration`
- `s3:PutBucketLogging`
- `s3:PutBucketLifecycleConfiguration`
- `s3:PutBucketCors`
- `s3:PutBucketObjectLockConfiguration`
- `s3:ListBucket`

If using SSE-KMS, also allow appropriate KMS permissions such as:

- `kms:DescribeKey`
- `kms:Encrypt`
- `kms:Decrypt`
- `kms:GenerateDataKey`

## 8. HCP Terraform Setup

### 8.1 Create HCP Terraform Organization

1. Sign in to:

```text
https://app.terraform.io
```

2. Create an organization.
3. Example:

```text
acme-platform
```

### 8.2 Create Workspaces

Create one workspace per environment-resource.

Recommended names:

- `project-a-dev-s3`
- `project-a-test-s3`
- `project-a-prod-s3`

This matches the workflow pattern:

```text
${PROJECT_NAME}-${environment}-s3
```

### 8.3 Generate HCP Terraform Token

1. In HCP Terraform, generate a user or team API token.
2. Store it in GitHub Secrets as:

```text
TF_API_TOKEN
```

### 8.4 Backend Configuration in Terraform

The service layer contains:

```hcl
terraform {
  backend "remote" {}
}
```

The workflow provides the actual backend settings during init:

```bash
terraform init -backend-config="organization=<org>" -backend-config="workspaces.name=<workspace>"
```

### 8.5 Remote State and Locking

HCP Terraform provides:

- Remote state storage
- Native state locking
- Workspace isolation per environment

## 9. Prepare the Separate Inputs Repository

Your input repository should contain environment values only.

Example `dev/terraform.tfvars`:

```hcl
aws_region          = "us-east-1"
environment         = "dev"
project_name        = "project-a"
owner               = "platform-team"
cost_center         = "cc-1001"
data_classification = "internal"

additional_tags = {
  Application = "project-a"
}

bucket_name             = "project-a-dev-s3-001-unique"
force_destroy           = false
versioning_enabled      = true
block_public_access     = true
object_ownership        = "BucketOwnerEnforced"
kms_key_arn             = null
allow_tls_requests_only = true
bucket_policy_json      = null

enable_access_logging  = false
access_log_bucket_name = null
access_log_prefix      = "s3-access-logs/project-a/dev/"

lifecycle_rules = []
cors_rules      = []

object_lock_enabled = false
object_lock_mode    = null
object_lock_days    = null
object_lock_years   = null

tags = {
  Workload   = "non-critical"
  Compliance = "internal"
}
```

Important:

- Bucket name must be globally unique.
- For production, replace KMS ARN and log bucket values with real values.
- Do not store secrets in plaintext tfvars.

## 10. Configure GitHub Environments

Create these GitHub Environments:

- `dev`
- `test`
- `production`

Recommended:

- Add approval rules for `production`.
- Restrict who can deploy to production.

## 11. Run the Workflow Step by Step

### Step 1: Push Terraform Repository

Make sure this repository is pushed to GitHub.

### Step 2: Push Inputs Repository

Push the separate input-values repository to GitHub.

### Step 3: Add Secrets and Variables

Add all secrets and variables described above.

### Step 4: Open GitHub Actions

1. Open your Terraform repo on GitHub.
2. Go to Actions.
3. Select workflow:

```text
s3-deploy
```

### Step 5: Run Workflow

Click `Run workflow` and enter:

1. `environment`
- `dev`, `test`, or `prod`

2. `tfvars_repository`
- Example:

```text
nishu-kumar7500/project-1
```

3. `tfvars_ref`
- Example:

```text
main
```

4. `tfvars_root`
- Example:

```text
.
```

### Step 6: Workflow Execution Order

The workflow will do this:

1. Checkout Terraform repo
2. Checkout tfvars repo
3. Verify tfvars file exists
4. Authenticate to AWS using OIDC and `AWS_DEPLOY_ROLE_ARN`
5. Authenticate to HCP Terraform using `TF_API_TOKEN`
6. Run `terraform fmt`
7. Run `terraform init`
8. Run `terraform validate`
9. Run `terraform plan`
10. Upload plan artifact
11. Run `terraform apply`

For production, apply should be controlled by GitHub Environment approval.

## 12. Verify Bucket Creation

After successful workflow execution:

1. Open AWS S3 Console.
2. Confirm bucket exists.
3. Check:
   - versioning enabled
   - block public access enabled
   - encryption enabled
   - TLS-only bucket policy applied
   - access logging enabled if configured

Also verify:

- HCP Terraform workspace contains current state
- Plan artifact exists in workflow run

## 13. Common Failure Points

1. `terraform.tfvars` path not found
- Verify the path matches:

```text
<tfvars_root>/<environment>/<service>/terraform.tfvars
```

2. `AWS_DEPLOY_ROLE_ARN` missing
- Add it as GitHub Secret.

3. `TF_API_TOKEN` missing
- Add it as GitHub Secret.

4. `INPUTS_REPO_TOKEN` missing for private repo
- Add it as GitHub Secret.

5. Bucket name already exists
- Use a globally unique name.

6. KMS ARN invalid or unauthorized
- Verify key exists and role has KMS permissions.

7. HCP workspace name mismatch
- Check `PROJECT_NAME` and selected `environment`.

## 14. Quick Checklist

Before running:

- Terraform repo pushed
- Inputs repo pushed
- AWS OIDC provider created
- GitHub IAM role created
- `AWS_DEPLOY_ROLE_ARN` secret added
- `TF_API_TOKEN` secret added
- `INPUTS_REPO_TOKEN` secret added if needed
- `HCP_ORGANIZATION` variable added
- `PROJECT_NAME` variable added
- `AWS_REGION` variable added
- `OWNER` variable added
- `COST_CENTER` variable added
- `DATA_CLASSIFICATION` variable added
- HCP workspaces created
- Production environment approval configured
