variable "project" {
  type        = string
  description = "project_id"
}
variable "env" {
  type        = string
  description = "environment (i.e dev, qa, stage, prod)"
}

variable "app" {
  type        = string
  description = "The name of the application (i.e hive)."
}

variable "region" {
  type        = string
  description = "Default region."
}
