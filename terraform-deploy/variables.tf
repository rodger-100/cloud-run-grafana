variable "project_id" {
  description = "The name of the project"
  type        = string
  default     = "pwc-rsx-rfx-dev"
}
variable "region" {
  description = "The default compute region"
  type        = string
  default     = "europe-west1"
}
variable "zone" {
  description = "The default compute zone"
  type        = string
  default     = "europe-west1-a"
}
variable "repository" {
  description = "The name of the Artifact Registry repository to be created"
  type        = string
  default     = "docker-repository"
}