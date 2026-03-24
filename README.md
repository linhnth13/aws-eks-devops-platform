# AWS EKS DevOps Platform
This project demonstrates a production-like DevOps setup using:
- AWS EKS
- Terraform
- Jenkins
- Docker
- Prometheus & Grafana
- Loki
## Architecture
(to be updated)

🏗️ Current Features

Infrastructure Provisioning (Terraform)
	•	Provisioned AWS VPC with custom CIDR
	•	Created multi-AZ architecture:
	•	Public subnets
	•	Private subnets
	•	Configured Internet Gateway and public routing
	•	Applied Kubernetes-ready subnet tagging

⸻

Modular Infrastructure Design
	•	Refactored Terraform code into reusable modules
	•	Separated environment-specific configuration (envs/dev)
	•	Improved maintainability and scalability of infrastructure code

⸻

Remote State Management
	•	Implemented remote state using AWS S3
	•	Enabled:
	•	Versioning for state recovery
	•	Server-side encryption
	•	Configured native state locking (use_lockfile = true)
	•	Migrated local state to remote backend

⸻

Bootstrap Infrastructure
	•	Created dedicated bootstrap Terraform configuration
	•	Automated S3 bucket provisioning for state management
	•	Follows best practice naming convention: `<project>-<env>-tfstate`
	•	Includes security hardening:
	•	S3 bucket versioning and encryption
	•	Public access blocking
	•	Native S3 state locking (`use_lockfile = true`)
	•	Modular file structure (versions.tf, providers.tf, variables.tf, main.tf, outputs.tf)

⸻

🛠️ Tech Stack
	•	Terraform
	•	AWS (VPC, S3)
	•	GitHub

⸻

📋 Quick Start

1. **Bootstrap Infrastructure** (First-time setup)
   ```bash
   cd terraform/bootstrap
   terraform init
   terraform plan
   terraform apply
   ```

2. **Configure Remote State** (After bootstrap)
   Update your Terraform configurations to use the remote backend:
   ```hcl
   terraform {
     backend "s3" {
       bucket       = "<project>-<env>-tfstate"
       key          = "terraform.tfstate"
       region       = "ap-southeast-1"
       use_lockfile = true
       encrypt      = true
     }
   }
   ```

3. **Deploy Infrastructure**
   ```bash
   cd terraform/envs/dev
   terraform init
   terraform plan
   terraform apply
   ```

⸻

🚀 Roadmap (In Progress)

The platform is being extended to include:
	•	NAT Gateway and private routing
	•	Amazon EKS cluster provisioning
	•	CI/CD pipeline with Jenkins
	•	Containerization with Docker
	•	Monitoring (Prometheus & Grafana)
	•	Centralized logging

⸻

🎯 Goal

To build a complete, production-like DevOps platform on AWS covering:
	•	Infrastructure as Code
	•	Kubernetes orchestration
	•	CI/CD automation
	•	Observability
