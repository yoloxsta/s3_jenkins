pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')  // Replace with your AWS credentials ID
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')  // Replace with your AWS credentials ID
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the code from your repository
                checkout scm
            }
        }
        stage('Install Terraform') {
            steps {
                // Install Terraform without using sudo
                sh 'curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -'
                sh 'apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"'
                sh 'apt-get update && apt-get install terraform'
            }
        }
        stage('Terraform Init') {
            steps {
                // Initialize Terraform
                sh 'terraform init'
            }
        }
        stage('Terraform Apply') {
            steps {
                // Apply Terraform configuration to create the S3 bucket
                sh 'terraform apply -auto-approve'
            }
        }
    }

    post {
        always {
            // Clean up, can be useful for sensitive info or logging
            cleanWs()
        }
    }
}
