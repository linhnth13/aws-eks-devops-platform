# Bootstrap Terraform Configuration

This directory contains the **bootstrap Terraform configuration** that must be run **before** deploying any other infrastructure in this project.

## Purpose

The bootstrap configuration creates the foundational AWS resources required for Terraform remote state management:

- **S3 Bucket**: Stores Terraform state files remotely

## Why Bootstrap?

Traditional Terraform setups require these resources to exist before enabling remote state. This creates a "chicken and egg" problem. The bootstrap configuration solves this by:

1. Using **local state** initially to create the remote state resources
2. Providing a clean separation between foundational infrastructure and application infrastructure
3. Following Infrastructure as Code principles for all AWS resources

## Resources Created

### S3 Bucket
- **Name**: `{project_name}-{environment}-tfstate` (e.g., `aws-eks-devops-platform-dev-tfstate`)
- **Versioning**: Enabled for state history and recovery
- **Encryption**: AES256 server-side encryption
- **Public Access**: Blocked for security

## Usage

### 1. Initialize and Plan
```bash
terraform init
terraform plan
```

### 2. Apply Bootstrap Resources
```bash
terraform apply
```

### 3. Note the Outputs
After successful apply, note the S3 bucket name from the outputs.

### 4. Configure Remote State
Update your main Terraform configurations to use remote backend:

```hcl
terraform {
  backend "s3" {
    bucket       = "aws-eks-devops-platform-dev-tfstate"  # From bootstrap output
    key          = "terraform.tfstate"
    region       = "ap-southeast-1"
    use_lockfile = true
    encrypt      = true
  }
}
```

## File Structure

- `versions.tf` - Terraform and provider version requirements
- `providers.tf` - AWS provider configuration
- `variables.tf` - Input variables (project, environment, region)
- `main.tf` - Resource definitions (S3 bucket)
- `outputs.tf` - Output values for use in other configurations

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `aws_region` | AWS region for resources | `ap-southeast-1` |
| `project_name` | Project identifier | `aws-eks-devops-platform` |
| `environment` | Environment name | `dev` |

## Security Considerations

- S3 bucket is configured with public access blocking
- Server-side encryption is enabled
- Resources are tagged for proper identification

## Cost Optimization

- S3 storage costs are minimal for Terraform state files
- No additional AWS services are provisioned beyond what's necessary

## Next Steps

After running bootstrap:
1. Configure your main Terraform configurations to use the remote backend
2. Run `terraform init` in your main configuration directories to migrate from local to remote state
3. Deploy your application infrastructure using the established state management

## Important Notes

- **Run bootstrap only once** per environment
- Bootstrap resources are foundational and should rarely change
- If you need to destroy bootstrap resources, ensure no other Terraform configurations depend on them
- Always test bootstrap changes in a separate environment first
