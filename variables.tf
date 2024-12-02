# Define variables for resources
variable "bucket_name" {
  default = "projectwebsiteexhibition"
}

variable "ec2_instance_type" {
  default = "t2.micro"
}

variable "azure_resource_group_name" {
  default = "WebsiteResourceGroup"
}

variable "azure_storage_account_name" {
  default = "websitestoragemilind11"
}
