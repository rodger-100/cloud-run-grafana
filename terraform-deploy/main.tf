resource "google_cloud_run_service" "grafana_run_service" {
  name = "grafana-rd"
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
   }

   traffic {
     percent = 100
     latest_revision = true

   }

   depends_on = [
     google_project_service.run_api
   ]
}

# Allow unauthenticated users to invoke the service
resource "google_cloud_run_service_iam_member" "run_all_users" {
  service  = google_cloud_run_service.grafana_run_service.name
  location = google_cloud_run_service.grafana_run_service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Display the service URL
output "service_url" {
  value = google_cloud_run_service.grafana_run_service.status[0].url
}