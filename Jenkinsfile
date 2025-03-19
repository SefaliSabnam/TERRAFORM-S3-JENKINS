pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'  // AWS region from Terraform variable
        BUCKET_NAME = 'sefali-terraform-bucket'  // S3 bucket name from Terraform variable
        SLACK_CHANNEL = '#jenkins'  // Slack channel name
        SLACK_WEBHOOK_URL = credentials('slack-webhook')  // Jenkins credential ID for Slack
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    echo "Checking out the repository..."
                    checkout scm
                }
            }
        }

        stage('Initialize Terraform') {
            steps {
                script {
                    echo "Initializing Terraform..."
                    sh 'terraform init'
                }
            }
        }

        stage('Validate Terraform') {
            steps {
                script {
                    echo "Validating Terraform files..."
                    sh 'terraform validate'
                }
            }
        }

        stage('Plan Terraform') {
            steps {
                script {
                    echo "Running Terraform plan..."
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Apply Terraform for Main') {
            when {
                branch 'main'
            }
            steps {
                script {
                    echo "Applying Terraform to deploy infrastructure..."
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Apply Terraform for Feature') {
            when {
                branch 'feature'
            }
            steps {
                script {
                    echo "Applying Terraform for feature branch (Staging)..."
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Skip Deployment for Other Branches') {
            when {expression {
                    env.BRANCH_NAME != 'main' && env.BRANCH_NAME != 'feature'
                }
            }
            steps {
                script {
                    echo "Skipping Terraform apply for branch: ${env.BRANCH_NAME}"
                }
            }
        }
    }

    post {
        success {
            script {
                echo "Terraform Deployment Successful!"
                slackSend(
                    channel: "${SLACK_CHANNEL}",
                    color: 'good',
                    message: " *Terraform Deployment Succeeded!* :rocket:\nBranch: *${env.BRANCH_NAME}*"
                )
            }
        }
        failure {
            script {
                echo " Terraform Deployment Failed!"
                slackSend(
                    channel: "${SLACK_CHANNEL}",
                    color: 'danger',
                    message: "*Terraform Deployment Failed!* :x:\nBranch: *${env.BRANCH_NAME}*"
                )
            }
        }
        always {
            script {
                echo " Cleaning up workspace..."
                cleanWs()
            }
        }
    }
}
