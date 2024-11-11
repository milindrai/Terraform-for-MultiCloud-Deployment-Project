# Display EC2 public IP and Azure Storage container URL
output "ec2_public_ip" {
  value       = aws_instance.web_server.public_ip
  description = "Public IP of the EC2 instance hosting the website"
}

output "azure_storage_url" {
  value       = azurerm_storage_account.storage.primary_blob_endpoint
  description = "Primary URL for Azure Blob Storage containing images and videos"
}
