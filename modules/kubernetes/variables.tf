variable "project" {
  type        = string
  description = "project_id"
}
variable "app" {
  type        = string
  description = "The name of the application (i.e hive)."
}
variable "region" {
  type        = string
  description = "Default region."
}
variable "zone" {
  type        = string
  description = "Default zone."
}

variable "network" {
  type        = string
  description = "VPC network."
}

variable "subnet" {
  type        = string
  description = "A subnets for resources."
}

variable "service_account" {
  type        = string
  description = "application service account"
}
