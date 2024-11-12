# AWS EC2 instance with EBS and S3 for static website deployment

# Security Group for HTTP Access
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow HTTP traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# IAM Role and policy for EC2 instance to access S3 bucket
resource "aws_iam_role" "ec2_role" {
  name = "EC2Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = { Service = "ec2.amazonaws.com" },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Policy for EC2 to Read from and Write to S3
resource "aws_iam_policy" "s3_access" {
  name        = "S3AccessPolicy"
  description = "Policy to allow bucket policy changes and object access"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutBucketPolicy",
          "s3:PutObject",
          "s3:GetObject"
        ],
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_access_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.ec2_role.name
}

# Create EC2 instance to host HTML files
resource "aws_instance" "web_server" {
  ami                  = "ami-00f251754ac5da7f0"
  instance_type        = var.ec2_instance_type
  security_groups      = [aws_security_group.web_sg.name]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y aws-cli httpd
    systemctl start httpd
    systemctl enable httpd

    # Copy files from S3 to /var/www/html
    aws s3 cp s3://${var.bucket_name}/index.html /var/www/html/index.html
    aws s3 cp s3://${var.bucket_name}/style.css /var/www/html/style.css
    systemctl restart httpd
  EOF

  tags = {
    Name = "EC2 Website Host"
  }
}

# Azure Resource Group for storage
resource "azurerm_resource_group" "rg" {
  name     = var.azure_resource_group_name
  location = "East US"
}

# Azure Storage Account for storing images/videos
resource "azurerm_storage_account" "storage" {
  name                     = var.azure_storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Azure Container and Blob Resources (Add blobs as needed)
resource "azurerm_storage_container" "media" {
  name                  = "media"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "container"
}


# Upload images to Azure Storage
resource "azurerm_storage_blob" "bg1" {
  name                   = "bg1.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/bg1.png"
}

resource "azurerm_storage_blob" "facebook" {
  name                   = "facebook.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/facebook.png"
}

resource "azurerm_storage_blob" "gir_dp2" {
  name                   = "gir_dp2.jpg"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/gir_dp2.jpg"
}

resource "azurerm_storage_blob" "gir_dp3" {
  name                   = "gir_dp3.jpg"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/gir_dp3.jpg"
}

resource "azurerm_storage_blob" "girl_dp1" {
  name                   = "girl_dp1.jpg"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/girl_dp1.jpg"
}

resource "azurerm_storage_blob" "google" {
  name                   = "google.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/google.png"
}

resource "azurerm_storage_blob" "loging_bg" {
  name                   = "loging_bg.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/loging_bg.png"
}

resource "azurerm_storage_blob" "logo" {
  name                   = "logo.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/logo.png"
}

resource "azurerm_storage_blob" "logshoes" {
  name                   = "logshoes.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/logshoes.png"
}

resource "azurerm_storage_blob" "man_dp1_png" {
  name                   = "man_dp1.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/man_dp1.jpg"
}

resource "azurerm_storage_blob" "man_dp2" {
  name                   = "man_dp2.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/man_dp2.jpg"
}

resource "azurerm_storage_blob" "man_dp3" {
  name                   = "man_dp3.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/man_dp3.jpg"
}

resource "azurerm_storage_blob" "nike" {
  name                   = "nike.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/nike.png"
}

resource "azurerm_storage_blob" "red_shoes1" {
  name                   = "red_shoes1.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/red_shoes1.png"
}

resource "azurerm_storage_blob" "red_shoes2" {
  name                   = "red_shoes2.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/red_shoes2.png"
}

resource "azurerm_storage_blob" "red_shoes3" {
  name                   = "red_shoes3.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/red_shoes3.png"
}

resource "azurerm_storage_blob" "red_shoes4" {
  name                   = "red_shoes4.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/red_shoes4.png"
}

resource "azurerm_storage_blob" "shoes" {
  name                   = "shoes.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/shoes.png"
}



resource "azurerm_storage_blob" "shoes2" {
  name                   = "shoes2.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/shoes2.png"
}

resource "azurerm_storage_blob" "shoes3" {
  name                   = "shoes3.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/shoes3.png"
}

resource "azurerm_storage_blob" "shoes4" {
  name                   = "shoes4.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/shoes4.png"
}

resource "azurerm_storage_blob" "shoes5" {
  name                   = "shoes5.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/shoes5.png"
}

resource "azurerm_storage_blob" "shoes6" {
  name                   = "shoes6.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/shoes6.png"
}

resource "azurerm_storage_blob" "shoes7" {
  name                   = "shoes7.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/shoes7.png"
}

resource "azurerm_storage_blob" "shoes8" {
  name                   = "shoes8.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/shoes8.png"
}

resource "azurerm_storage_blob" "twitter" {
  name                   = "twitter.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/twitter.png"
}














# S3 Bucket for static website
resource "aws_s3_bucket" "website_bucket" {
  bucket = "myterraformprojectwebsite"
}

# Configure bucket to allow public access
resource "aws_s3_bucket_public_access_block" "website_bucket_access" {
  bucket                  = aws_s3_bucket.website_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Website configuration for S3 bucket
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }
}

# Public access policy for S3 bucket
resource "aws_s3_bucket_policy" "public_access_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.website_bucket.id}/*"
      }
    ]
  })
}

# S3 objects for HTML files
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "project_website/index.html"
}

resource "aws_s3_object" "style_css" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "style.css"
  source = "project_website/style.css"
}

# Ensure Azure storage account and container are correctly configured
resource "azurerm_storage_blob" "shoes1" {
  name                   = "shoes1.png"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.media.name
  type                   = "Block"
  source                 = "project_website/image/shoes1.png"
}