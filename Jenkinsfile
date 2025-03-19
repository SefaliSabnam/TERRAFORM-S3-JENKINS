pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        BUCKET_NAME_MAIN = 'sefali-main-bucket'
        BUCKET_NAME_UT1234 = 'sefali-ut1234-bucket'
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

        // Deploy to Main
        stage('Deploy to Main Bucket') {
            when {
                expression { env.GIT_BRANCH == 'origin/main' }
            }
            steps {
                script {
                    withCredentials([
                        [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS_KEY_ID_1']
                    ]) {
                        sh '''
                        echo "Deploying index.html to Main Bucket: $BUCKET_NAME_MAIN"
                        aws s3 cp index.html s3://$BUCKET_NAME_MAIN --region $AWS_REGION --acl public-read
                        '''
                    }
                }
            }
        }

        // Deploy to UT-1234
        stage('Deploy to UT-1234 Bucket') {
            when {
                expression { env.GIT_BRANCH == 'origin/UT-1234' }
            }
            steps {
                script {
                    withCredentials([
                        [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS_KEY_ID_1']
                    ]) {
                        sh '''
                        echo "Deploying index.html to UT-1234 Bucket: $BUCKET_NAME_UT1234"
                        aws s3 cp index.html s3://$BUCKET_NAME_UT1234 --region $AWS_REGION --acl public-read
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
