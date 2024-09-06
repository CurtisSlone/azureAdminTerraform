variable "rg_name" {
  type = string
}

variable "rg_location"{
    type = string
}

# variable "default_tags" {
#   type = map(string)
# }

variable "win_vm_name"{
  type = string
}

variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "win_vm_nic_name" {
  type = string
}

variable "win_vm_username" {
  type = string
}

variable "win_vm_password" {
  type = string
}

variable "keyvault_name" {
  type = string
}

variable "encryption_key" {
  type = string
}