# MEAN Stack Terraform Automation

This project automates the deployment of a MEAN stack application on AWS using Terraform.

## Prerequisites

Before running Terraform, make sure you have:

1. Installed [Terraform](https://www.terraform.io/downloads.html)
2. Installed [AWS CLI](https://aws.amazon.com/cli/)
3. Configured AWS credentials

## AWS Credentials Setup

To configure AWS credentials, you need to set up the AWS CLI:

```bash
aws configure
```

This will prompt you for:
- AWS Access Key ID
- AWS Secret Access Key
- Default region name (e.g., us-east-1)
- Default output format (json is recommended)

This command creates a credentials file at `~/.aws/credentials` that Terraform will use to authenticate with AWS.

Alternatively, you can set environment variables:

```bash
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
```

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Plan the deployment:
```bash
terraform plan
```

3. Apply the changes:
```bash
terraform apply
```

4. To destroy the infrastructure:
```bash
terraform destroy
```