pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID_1')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID_1')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    def initStatus = sh(script: 'terraform init -migrate-state', returnStatus: true)
                    if (initStatus != 0) {
                        echo "Backend configuration changed. Running terraform init -reconfigure..."
                        sh 'terraform init -reconfigure'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Merge Check and Apply') {
            when {
                branch 'main'
            }
            steps {
                script {
                    def prevCommit = sh(script: 'git rev-parse --verify --quiet $GIT_PREVIOUS_SUCCESSFUL_COMMIT || echo ""', returnStdout: true).trim()
                    def latestCommit = sh(script: 'git rev-parse HEAD', returnStdout: true).trim()

                    if (!prevCommit) {
                        echo "No previous successful commit found. Running terraform apply..."
                        sh 'terraform apply -auto-approve tfplan'
                        slackNotification("Terraform apply successful! ")
                    } else if (prevCommit != latestCommit) {
                        echo "Changes detected! Running terraform apply..."
                        sh 'terraform apply -auto-approve tfplan'
                        slackNotification("Terraform apply successful! ")
                    } else {
                        echo "No changes detected. Skipping terraform apply."
                    }
                }
            }
        }
    }

    post {
        success {
            script {
                slackNotification("Terraform deployment successful! ")
            }
        }
        failure {
            script {
                slackNotification("Terraform deployment failed! ")
            }
        }
    }
}

def slackNotification(message) {
    slackSend(channel: '#jenkins', message: message)
}
