variable "rg_name" {
  type = string
}

variable "rg_location"{
    type = string
}

variable "default_tags" {
  type = map(string)
}

variable "storage_account_name" {
  type = string
}

variable "storage_container_name" {
  type = string
}

variable "application_display_name" {
  type = string
}