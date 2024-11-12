# Terraform Multi-Cloud Project

This Terraform project is designed to manage infrastructure across multiple cloud providers, including AWS and Azure. It automates the deployment of various resources such as virtual machines, storage accounts, and databases across these platforms.

## Project Structure

- `main.tf`: Contains the Terraform configuration for AWS S3 buckets, objects, website configuration, EC2 instances, IAM roles, policies, and Azure resources.
- `provider.tf`: Specifies the Terraform providers and their versions, in this case, AWS and Azure.
- `variables.tf`: Defines variables used in the Terraform configurations.
- `outputs.tf`: Defines outputs from Terraform that can be useful for further configurations or information.
- `.gitignore`: Specifies files and directories to be ignored by git.
- `project_website/`: Contains the HTML and CSS files for the website.

## Prerequisites

- Terraform installed on your local machine.
- An AWS account with access to S3 and EC2.
- An Azure account with access to resource groups and storage accounts.
- AWS CLI configured with access credentials.
- Azure CLI configured with access credentials.

## Usage

1. **Initialize Terraform**

   Run the following command to initialize Terraform in your project directory. This will download the necessary providers and modules.

   ```sh
   terraform init
2. **Plan the Terraform Execution**

   Execute the following command to see the actions Terraform will perform.

   ```sh
   terraform plan
3. **Apply the Configuration**

   Apply the Terraform configuration to start provisioning the resources on AWS.

   ```sh
   terraform apply
   ```
   Confirm the action when prompted to start the process.
4. **Access Your Website**

   Once the apply command completes, your static website will be accessible through the S3 bucket's website endpoint.
5. **Cleanup**

   To remove the resources created by this project, run:

   ```sh
   terraform destroy
   ```
   Confirm the action when prompted to delete the resources.

## Resources Created

**AWS-**
- S3 Bucket for website hosting
- S3 Bucket Policy for public access
- S3 Objects for HTML and CSS files
- IAM Role and Policy for EC2 instance to access S3
- EC2 Instance to host the website
- Security Group for HTTP access

**Azure-**
- Resource Group
- Storage Account
