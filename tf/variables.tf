variable "GOOGLE_PROJECT" {
  type        = string
  default     = "demopj-430611"
  description = "GCP project name"
}

variable "GOOGLE_REGION" {
  type        = string
  default     = "europe-west1-b"
  description = "GCP region to use"
}

variable "GITHUB_OWNER" {
  type        = string
  description = "Github owner repositiry"
}

variable "GITHUB_TOKEN" {
  type        = string
  description = "Github personal access token"
}

variable "FLUX_GITHUB_REPO" {
  type        = string
  default     = "flux-gitops"
  description = "Flux GitOps repository"
}

variable "FLUX_GITHUB_TARGET_PATH" {
  type        = string
  default     = "clusters"
  description = "Flux manifest subdirectory"
}

variable "GKE_NUM_NODES" {
  type        = number
  default     = 2
  description = "GKE nodes number"
}

variable "G_BUCKET_NAME" {
  type        = string
  description = "Google bucket name"
}