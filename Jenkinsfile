pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        BUCKET_NAME = 'sefali-terraform-bucket'
        SLACK_CHANNEL = '#jenkins'
        SLACK_WEBHOOK_URL = credentials('slack-webhook')
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
                    withCredentials([
                        aws(credentialsId: 'AWS_ACCESS_KEY_ID_1')
                    ]) {
                        sh '''
                        terraform init \
                          -backend-config="bucket=$BUCKET_NAME" \
                          -backend-config="region=$AWS_REGION"
                        '''
                    }
                }
            }
        }

        stage('Validate Terraform') {
            steps {
                script {
                    sh 'terraform validate'
                }
            }
        }

        stage('Plan Terraform') {
            steps {
                script {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Apply Terraform for Main') {
            when {
                expression { env.GIT_BRANCH == 'origin/main' }
            }
            steps {
                script {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Apply Terraform for Feature') {
            when {
                expression { env.GIT_BRANCH == 'origin/feature' }
            }
            steps {
                script {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success {
            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: "good",
                message: "*Terraform Deployment Succeeded!* :rocket:\nBranch: *${env.GIT_BRANCH}*"
            )
        }
        failure {
            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: "danger",
                message: "*Terraform Deployment Failed!* :x:\nBranch: *${env.GIT_BRANCH}*"
            )
        }
        always {
            cleanWs()
        }
    }
}
