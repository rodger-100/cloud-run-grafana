terraform {
  required_version = ">=0.14"

  required_providers {
    google = ">=3.3"
  }
}

provider "google" {
    project = "pwc-rsx-rfx-dev"
}

resource "google_project_service" "run_api" {
    service = "run.googleapis.com"
  }