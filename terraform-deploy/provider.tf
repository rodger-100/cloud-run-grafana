terraform {
  required_version = ">=0.14"

  required_providers {
    google = ">=3.3"
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.25.0"
    }
  }
}

provider "google" {
  project = "pwc-rsx-rfx-dev"
  region  = "europe-west1"
}

provider "google-beta" {
  project = "pwc-rsx-rfx-dev"
  region  = "europe-west1"

}

