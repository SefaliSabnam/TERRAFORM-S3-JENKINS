# AWS S3 STATIC WEBSITE HOSTING WITH TERRAFORM AND JENKINS


## PROJECT OVERVIEW

This project automates the deployment of a static website on AWS S3 using Terraform, with a Jenkins multi-branch pipeline for continuous deployment. The website is hosted on an S3 bucket and configured for public access. Terraform is used for infrastructure provisioning, and Jenkins automates the deployment process.

## TABLE OF CONTENTS

- [ARCHITECTURE](#architecture)
- [PREREQUISITES](#prerequisites)
- [PROJECT STRUCTURE](#project-structure)
- [TERRAFORM SETUP](#terraform-setup)
- [JENKINS AUTOMATION](#jenkins-automation)
- [DEPLOYMENT WORKFLOW](#deployment-workflow)
- [EXPECTED OUTPUT](#expected-output)
- [DESTROYING THE INFRASTRUCTURE](#destroying-the-infrastructure)
- [LICENSE](#license)
- [CONTRIBUTION](#contribution)

## ARCHITECTURE

![Architecture Diagram](terraform%20s3.drawio%20(1).png)


- **GITHUB**: Stores Terraform and Jenkins configuration files.
- **VISUAL STUDIO CODE**: Used for writing and managing Terraform and Jenkins files.
- **JENKINS**: Triggers the Terraform deployment process upon code merge.
- **TERRAFORM**: Provisions the AWS resources, including IAM roles and S3 buckets.
- **AWS CLOUD (AP-SOUTH-1)**: Hosts the S3 bucket containing the static website files.
- **IAM POLICY**: Manages access to AWS resources.
- **HTML FILES**: The website content is stored in the S3 bucket and served publicly.

## PREREQUISITES

- Install [TERRAFORM](https://developer.hashicorp.com/terraform/downloads)
- Install [JENKINS](https://www.jenkins.io/doc/book/installing/)
- Configure [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

## PROJECT STRUCTURE

├── index.html # Main HTML file for the website 
├── error.html # Custom error page 
├── main.tf # Terraform configuration 
├── provider.tf # Terraform provider settings 
├── variables.tf # Terraform variables 
├── backend.tf # Terraform backend configuration 
├── output.tf # Terraform output definitions 
├── Jenkinsfile # Jenkins pipeline definition 
├── README.docx # Project documentation

## TERRAFORM SETUP
- Define the AWS provider and required variables in `provider.tf` and `variables.tf`.
- Create an S3 bucket for static website hosting in `main.tf`.
- Configure public access and bucket policies.
- Upload `index.html` and `error.html` to the S3 bucket.
- Store the Terraform state file in an S3 backend (if applicable).

## JENKINS AUTOMATION
- Add the repository to Jenkins.
- Set up a multibranch pipeline.
- Use the provided `Jenkinsfile` for automation.

## DEPLOYMENT WORKFLOW
1. Jenkins fetches the Terraform code from GitHub.
2. Runs Terraform commands (`init`, `apply`) to create/update infrastructure.
3. Deploys website files (`index.html`, `error.html`) to S3.
4. Validate website availability via the S3 static website URL.
5. Use AWS CloudWatch for monitoring and logging.

## EXPECTED OUTPUT
Once the deployment is successful, the following outputs are expected:

- **Terraform Output**:
  - S3 bucket is successfully created.
  - Website files (`index.html`, `error.html`) are uploaded.
  - Public access is enabled, allowing users to view the site.
  - Terraform state file is stored in the configured S3 backend.

- **Jenkins Pipeline Output**:
  - The pipeline successfully initializes, validates, and applies the Terraform configuration.
  - Website files are deployed to S3.
  - Terraform state file upload confirmation in the logs.
  - Confirmation message showing a successful deployment.

- **Website Access**:
  - Open the provided S3 static website URL in a browser.
  - The homepage (`index.html`) should be displayed.
  - Navigating to a non-existent page should show the custom `error.html` page.

## DESTROYING THE INFRASTRUCTURE
To remove all AWS resources created by Terraform:
```sh
terraform destroy -auto-approve


## LICENSE
This project is licensed under the [MIT License](LICENSE).

## CONTRIBUTION

Contributions are welcome! Feel free to submit pull requests to enhance this project.
