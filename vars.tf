variable "resource_location" {
  description = "Desired location to provision the resources. Eg UK South"
  type        = string
#  default    = "UK South"
}

variable "resource_prefix" {
  description = "Desired prefix for the provisioned resources. Eg CC-D-UKS"
  type        = string
#  default    = "CC-D-UKS"
}

variable "remote_location" {
  description = "Your public IP address. This will allow whitelisted access to the provisioned instance and storage account"
  type        = string
#  default    = "1.1.1.1/32"
}

variable "admin_username" {
  description = "Appropriate value which will be used to log into the instance"
  type        = string
#  default    = "changeme"
}

variable "admin_password" {
  description = "Appropriate value which will be used to log into the instance"
  type        = string
#  default    = "changeme"
}