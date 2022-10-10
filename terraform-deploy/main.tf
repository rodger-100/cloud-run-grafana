resource "google_cloud_run_service" "grafana_run_service" {
  provider = google-beta
  name     = "grafana-rd"
  location = "europe-west1"
  template {
    spec {
      containers {
        image = "gcr.io/pwc-rsx-rfx-dev/grafana:latest"

        ports {
          container_port = 3000
        }

      }
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = "0"
        "autoscaling.knative.dev/maxScale" = "1"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true

  }

  depends_on = [
    google_project_service.cloudrun
  ]
}

# Allow unauthenticated users to invoke the service
#resource "google_cloud_run_service_iam_member" "run_all_users" {
#  service  = google_cloud_run_service.grafana_run_service.name
#  location = google_cloud_run_service.grafana_run_service.location
#  role     = "roles/run.invoker"
#  member   = "allUsers"
#}

# Apply the no-authentication policy to our Cloud Run Service.
resource "google_cloud_run_service_iam_policy" "noauth" {
  provider    = google-beta
  location    = var.region
  project     = var.project_id
  service     = google_cloud_run_service.grafana_run_service.name
  policy_data = data.google_iam_policy.noauth.policy_data
}

# Create a policy that allows all users to invoke the API
data "google_iam_policy" "noauth" {
  provider = google-beta
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

# Display the service URL
output "service_url" {
  value = google_cloud_run_service.grafana_run_service.status[0].url
}


# This is used so there is some time for the activation of the API's to propagate through
# Google Cloud before actually calling them.
resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"
  depends_on = [
    google_project_service.cloudrun,
    #google_project_service.resourcemanager
  ]
}