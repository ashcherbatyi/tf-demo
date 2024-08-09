# Terraform GKE Cluster with FluxCD Integration

This Terraform configuration sets up a Google Kubernetes Engine (GKE) cluster and bootstraps it with FluxCD for GitOps. The configuration also manages a GitHub repository for Flux manifests, along with the necessary SSH keys for secure Git operations.

## Prerequisites

- Terraform installed on your machine.
- Google Cloud Platform (GCP) account with necessary permissions.
- A GitHub account with a personal access token (PAT) that has the necessary permissions for repository management.

## Modules Used

This configuration uses several Terraform modules to manage different components:

1. **GitHub Repository Module**:
   - Source: [tf-github-repository](https://github.com/ashcherbatyi/tf-github-repository)
   - This module manages the creation of a GitHub repository and adds the necessary SSH deploy key for Flux to access the repository.

2. **GKE Cluster Module**:
   - Source: [tf-google-gke-cluster](https://github.com/ashcherbatyi/tf-google-gke-cluster)
   - This module sets up a GKE cluster with the specified configuration.

3. **FluxCD Bootstrap Module**:
   - Source: [tf-fluxcd-flux-bootstrap](https://github.com/ashcherbatyi/tf-fluxcd-flux-bootstrap)
   - This module bootstraps FluxCD into the GKE cluster and connects it to the GitHub repository created earlier.

4. **TLS Private Key Module**:
   - Source: [tf-hashicorp-tls-keys](https://github.com/ashcherbatyi/tf-hashicorp-tls-keys)
   - This module generates an RSA private key for use with the GitHub repository.

## Steps to Deploy

1. **Clone the repository**:
   ```bash
   git clone https://github.com/ashcherbatyi/tf-demo.git
   cd tf-demo/tf
   ```

2. **Configure variables**:
   Create the `variables.tfvars` file with your specific values or pass them via the command line.

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Preview the changes**:
   ```bash
   terraform plan or terraform plan -var-file="variables.tfvars"
   ```

5. **Apply the configuration**:
   ```bash
   terraform apply or terraform apply -var-file="variables.tfvars"
   ```

6. **Check the deployment**:
   Verify that the GKE cluster is up and running and that FluxCD is properly bootstrapped with the GitHub repository.


## Important Note
- It is recommended to perform the deployment steps in Google Cloud Shell to ensure all necessary tools and permissions are available.

- Pay special attention to the variable `FLUX_GITHUB_REPO`. This variable specifies the name of the repository from which Flux will synchronize manifests. This repository will be created automatically after executing terraform apply. In the `clusters` folder you should put manifests on your PET project to track changes. 
For Example `kbot.yaml`:

```
apiVersion: source.toolkit.fluxcd.io/v1
kind: GitRepository
metadata:
  name: kbot
  namespace: demo
spec:
  interval: 1m0s
  ref:
    branch: main
  url: https://github.com/ashcherbatyi/kbot
```