
variable "project" {
  type        = string
  description = "project_id"
}

variable "env" {
  type        = string
  description = "enviroment."
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
  description = "Default zone within region."
}

variable "db_machine_type" {
  type        = string
  description = "The machine type of the database"
}