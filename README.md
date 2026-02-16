🚀 AWS Landing Zone – Production-Ready VPC Architecture
    
    📌 Project Overview
        This project provisions a production-ready AWS Landing Zone using Terraform.
        The goal is to establish a secure, scalable, and enterprise-grade network foundation that can host application workloads in public and private environments.

    This implementation includes:
        Multi-AZ VPC architecture
        Public and private subnets
        Internet Gateway
        NAT Gateway
        Route tables and associations
        VPC Flow Logs
        Remote backend using S3 + DynamoDB (state locking)
    
🧱 Infrastructure Components
    🌐 Networking
        VPC (10.0.0.0/16)
        2 Public Subnets (Multi-AZ)
        2 Private Subnets (Multi-AZ)
        Internet Gateway
        NAT Gateway
        Public Route Table
        Private Route Table
🔐 Security & Observability
    VPC Flow Logs enabled
    CloudWatch Log Group
    IAM Role for Flow Logs
🗂️ Terraform Backend
    Remote State stored in S3
    DynamoDB used for state locking
    S3 versioning enabled
    State encryption enabled\
🧰 Technologies Used
    Terraform
    AWS VPC
    AWS IAM
    AWS CloudWatch
    AWS S3
    AWS DynamoDB
    Git
    GitHub

📁 Project Structure
aws-landing-zone-terraform/
│
├── main.tf
├── variables.tf
├── providers.tf
├── backend.tf
├── .gitignore
└── README.md

🚀 Deployment Instructions
    1️⃣ Prerequisites
        AWS Account
        IAM user with programmatic access
        AWS CLI configured
        Terraform installed

    2️⃣ Initialize Terraform
        # terraform init
    
    3️⃣ Validate Configuration
        # terraform validate

    4️⃣ Review Execution Plan
        # terraform plan
    
    5️⃣ Apply Infrastructure
        # terraform apply

🔐 Remote Backend Setup
Before running terraform init, ensure:
    S3 bucket exists
    DynamoDB table exists
    Backend configuration in backend.tf is updated with correct bucket name


🧠 Design Decisions
Multi-AZ Deployment
    Ensures high availability and fault tolerance.

Public vs Private Subnets
    Public subnets expose internet-facing resources.
    Private subnets protect internal workloads.

NAT Gateway
    Allows outbound internet access for private subnets without exposing them.

Remote Backend
    Prevents state corruption and enables safe collaboration.

📊 Security Considerations
    No public EC2 instances deployed by default
    Private subnets isolated
    Flow logs enabled for monitoring
    State encryption enabled
    Public access blocked on S3 bucket

💰 Cost Awareness

⚠️ NAT Gateway incurs cost (~$30+/month).
Ensure you destroy resources after testing:
    # terraform destroy