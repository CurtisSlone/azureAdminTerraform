variable "rg_name" {
  type = string
}

variable "rg_location"{
    type = string
}

variable "default_tags" {
  type = map(string)
}

variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}