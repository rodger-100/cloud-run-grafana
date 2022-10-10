#############################################
#               Enable API's                #
#############################################


# Enable Cloud Run API
resource "google_project_service" "cloudrun" {
  provider           = google-beta
  service            = "run.googleapis.com"
  disable_on_destroy = false
}
