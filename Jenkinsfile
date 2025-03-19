pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        BUCKET_NAME = 'sefali-terraform-bucket' // Single bucket from Terraform
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

        // Deploy to S3 based on branch
        stage('Deploy to S3 Bucket') {
            when {
                anyOf {
                    expression { env.GIT_BRANCH == 'main' }
                    expression { env.GIT_BRANCH == 'UT-1234' }
                }
            }
            steps {
                script {
                    withCredentials([
                        [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS_KEY_ID_1']
                    ]) {
                        sh '''
                        echo "Deploying index.html to S3 Bucket: $BUCKET_NAME"
                        aws s3 cp index.html s3://$BUCKET_NAME --region $AWS_REGION --acl public-read
                        '''
                    }
                }
            }
        }
    }

    post {
        success {
            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: "good",
                message: "*Deployment Succeeded!* :rocket:\nBranch: *${env.GIT_BRANCH}*\nFile: *index.html* uploaded successfully."
            )
        }
        failure {
            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: "danger",
                message: "*Deployment Failed!* :x:\nBranch: *${env.GIT_BRANCH}*\nFailed to upload *index.html*."
            )
        }
        always {
            cleanWs()
        }
    }
}
