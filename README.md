# BlueWhite Project

This repository contains the source code and infrastructure code for the BlueWhite project.

## Description

The BlueWhite project aims to deploy a Flask application using Kubernetes and Terraform. The project consists of two main directories:

- **bluewhite-app**: Contains the Flask application code and Dockerfile for containerization.
- **bluewhite-tf**: Contains the Terraform code and Helm chart for deploying the application to Google Cloud Platform (GCP) using Kubernetes.

## Prerequisites

Before you begin, make sure you have the following requirements set up:

- **Google Cloud Platform (GCP) Account**: Sign up for a GCP account and set up your project.
- **Authentication**: Authenticate with GCP using appropriate credentials. Refer to the GCP documentation for authentication setup.
- **Terraform**: Install Terraform on your local machine. Refer to the Terraform documentation for installation instructions.

## Getting Started

To set up and deploy the BlueWhite project, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/chacharGIT/bluewhite-project/tree/main
   ```

2. Configure the Terraform backend:

Update the configuration in the bluewhite-tf/variables.tfvars file to reflect your GCP project details.

3. Initialize Terraform:

   ```bash
   cd bluewhite-tf
   terraform init
   ```

4. Deploy the infrastructure:
 
   ```bash
   terraform apply -var-file variables.tfvars
   ```
5. Access the application:

Once the deployment is complete, you can access the Flask application using the provided URL or the ingress endpoint.
