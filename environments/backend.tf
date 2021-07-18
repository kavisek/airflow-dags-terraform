
terraform {
  backend "gcs" {
    bucket = "kavi-prod-airflow-dags"
    prefix = "env/prod"
  }
}
