# CodeCraft Deployment

This repository contains the infrastructure and deployment configuration for the CodeCraft .NET Core API application.

## Project Structure

```
├── app/                  # .NET Core API project
│   └── Dockerfile
│
├── terraform/            # Terraform scripts
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── k8s/                  # Kubernetes manifests
│   ├── deployment.yaml
│   └── service.yaml
│
├── Jenkinsfile           # Jenkins pipeline definition
└── README.md             # Documentation
```

## Prerequisites

- Docker
- Kubernetes cluster
- Terraform
- Jenkins
- Azure CLI (if using Azure)

## Getting Started

1. Build the Docker image:
   ```bash
   cd app
   docker build -t codecraft-api .
   ```

2. Initialize Terraform:
   ```bash
   cd terraform
   terraform init
   ```

3. Apply Terraform configuration:
   ```bash
   terraform apply
   ```

4. Deploy to Kubernetes:
   ```bash
   kubectl apply -f k8s/
   ```

## CI/CD Pipeline

The project includes a Jenkins pipeline that automates:
- Building the Docker image
- Running tests
- Deploying to Kubernetes
- Infrastructure provisioning with Terraform

## Infrastructure

The infrastructure is managed using Terraform and includes:
- Kubernetes cluster
- Container registry
- Network resources
- Storage resources

## Monitoring and Logging

- Application logs are collected using Kubernetes logging
- Metrics are exposed through Prometheus endpoints
- Grafana dashboards are available for visualization

## Security

- Secrets are managed through Kubernetes Secrets
- Network policies are implemented
- RBAC is configured for access control

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License. 