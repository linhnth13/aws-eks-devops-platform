# AWS EKS DevOps Platform

This project demonstrates a production-like DevOps setup using AWS EKS and Terraform.

## Tech Stack

- Terraform
- AWS (VPC, S3, EKS)
- Jenkins
- Docker
- Prometheus/Grafana/Loki

## Current Terraform Scope

- Reusable VPC module: `terraform/modules/vpc`
- EKS module (in progress): `terraform/modules/eks`
- Environment roots:
  - `terraform/envs/dev`
  - `terraform/envs/staging`
  - `terraform/envs/prod`
- Bootstrap for remote state: `terraform/bootstrap`

## Remote State Strategy (Best Practice)

State is isolated by environment. We keep the naming convention:

- `aws-eks-devops-platform-dev-tfstate`
- `aws-eks-devops-platform-staging-tfstate`
- `aws-eks-devops-platform-prod-tfstate`

Each environment uses:

- A dedicated S3 backend bucket
- A dedicated state key (`terraform.tfstate`) in that bucket
- S3 native locking (`use_lockfile = true`)
- Versioning + encryption enabled at bucket level (created by bootstrap)

This prevents accidental cross-environment impact and follows enterprise-style isolation.

## Bootstrap Backend Buckets

Run bootstrap once per environment to create the backend S3 bucket.

### Dev

```bash
cd terraform/bootstrap
terraform init
terraform apply -var="environment=dev"
```

### Staging

```bash
cd terraform/bootstrap
terraform apply -var="environment=staging"
```

### Prod

```bash
cd terraform/bootstrap
terraform apply -var="environment=prod"
```

## Deploy By Environment

### Dev

```bash
cd terraform/envs/dev
terraform init
terraform plan
terraform apply
```

### Staging

```bash
cd terraform/envs/staging
terraform init
terraform plan
terraform apply
```

### Prod

```bash
cd terraform/envs/prod
terraform init
terraform plan
terraform apply
```

## Terraform Notes

- Each folder with `main.tf` is a separate Terraform root module.
- Root modules consume child module outputs only (for example `module.vpc.vpc_id`).
- Do not reference child resources directly across module boundaries.
- Review `docs/terraform_plan.md` for the step-by-step hands-on learning path.
