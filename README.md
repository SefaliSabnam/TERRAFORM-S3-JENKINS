AWS S3 STATIC WEBSITE HOSTING WITH TERRAFORM AND JENKINS:
========================================================

PROJECT OVERVIEW:
=================
This project automates the deployment of a static website on AWS S3 using Terraform, with a Jenkins multi-branch pipeline for continuous deployment. The website is hosted on an S3 bucket and configured for public access. Terraform is used for infrastructure provisioning, and Jenkins automates the deployment process.

What is Terraform?
==================

Terraform is an open-source infrastructure as a code (IAC) tool that allows to create, manage & deploy the production-ready environment. Terraform codifies cloud APIs into declarative configuration files. Terraform can manage both existing service providers and custom in-house solutions.


ARCHITECTURE:
=============

![alt text](<terraform s3.drawio (1).png>)
 
The architecture consists of the following components:
•	GitHub: Stores Terraform and Jenkins configuration files.
•	Visual Studio Code: Used for writing and managing Terraform and Jenkins files.
•	Jenkins: Triggers the Terraform deployment process upon code merge.
•	Terraform: Provisions the AWS resources, including IAM roles and S3 buckets.
•	AWS Cloud (ap-south-1): Hosts the S3 bucket containing the static website files.
•	IAM Policy: Manages access to AWS resources.
•	HTML Files: The website content is stored in the S3 bucket and served publicly.



TECHNOLOGY STACK:
================
•	AWS Services: S3, IAM
•	Terraform: Infrastructure as Code (IaC)
•	Jenkins: CI/CD automation
•	GitHub: Source code repository
•	HTML & CSS: Website content
•	VISUAL STUDIO

PROJECT STRUCTURE:
==================

├── index.html           # Main HTML file for the website
├── error.html           # Custom error page
├── main.tf              # Terraform configuration
├── provider.tf          # Terraform provider settings
├── variables.tf         # Terraform variables
├── Jenkinsfile          # Jenkins pipeline definition
├── README.docx          # Project documentationWorkflow


1. Infrastructure Setup with Terraform
=======================================
•	Define the AWS provider and required variables in provider.tf and variables.tf.
•	Create an S3 bucket for static website hosting in main.tf.
•	Configure public access and bucket policies.
•	Upload index.html and error.html to the S3 bucket.
•	Store the Terraform state file in an S3 backend (if applicable).


2. CI/CD with Jenkins
=====================
•	Jenkins fetches the Terraform code from GitHub.
•	Runs Terraform commands (init, apply) to create/update infrastructure.
•	Deploys website files (index.html, error.html) to S3.


3. Deployment & Monitoring
==========================
•	Validate website availability via the S3 static website URL.
•	Use AWS CloudWatch for monitoring and logging.


SETUP INSTRUCTIONS:
===================

1. Install Prerequisites
•	Install Terraform (Download)
•	Install Jenkins (Setup Guide)
•	Configure AWS CLI 

2. Clone the Repository
git clone <repository_url>
cd <project_directory>

3. Configure AWS Credentials
export AWS_ACCESS_KEY_ID=your-access-key
export AWS_SECRET_ACCESS_KEY=your-secret-key

4. Initialize and Apply Terraform
cd terraform
terraform init
terraform apply -auto-approve

5. Configure Jenkins Pipeline
•	Add the repository to Jenkins.
•	Set up a multibranch pipeline.
•	Use the provided Jenkinsfile for automation.

6. Access the Deployed Website
•	Retrieve the S3 static website URL from Terraform output.
•	Open it in a browser to verify deployment.

EXPECTED OUTCOME:
================
•	A publicly accessible static website hosted on AWS S3.
•	Automated deployment using Jenkins.
•	Infrastructure managed efficiently with Terraform.

CLEANUP:
========
To remove all AWS resources created by Terraform:
terraform destroy -auto-approve

License
=======
This project is licensed under the MIT License. See LICENSE for details.

Contribution
============
Feel free to contribute to this project by submitting pull requests.


