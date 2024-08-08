module "github_repository" {
  source                   = "github.com/ashcherbatyi/tf-github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux0"
}
module "gke_cluster" {
  source         = "github.com/ashcherbatyi/tf-google-gke-cluster"
  GOOGLE_REGION  = var.GOOGLE_REGION
  GOOGLE_PROJECT = var.GOOGLE_PROJECT
}

module "flux_bootstrap" {
  source            = "github.com/ashcherbatyi/tf-fluxcd-flux-bootstrap"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  github_token      = var.GITHUB_TOKEN
  private_key       = module.tls_private_key.private_key_pem
  config_path       = module.gke_cluster.kubeconfig
}

module "tls_private_key" {
  source    = "github.com/ashcherbatyi/tf-hashicorp-tls-keys"
  algorithm = "RSA"
}

terraform {
  backend "gcs" {
    bucket  = "ashcherbatyi-demo-1"
    prefix  = "terraform/state"
  }
}
