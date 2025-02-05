pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')  // Replace with your AWS credentials ID
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')  // Replace with your AWS credentials ID
    }

    stages {
        stage('Install Terraform') {
            steps {
                // Install Terraform on the Jenkins agent/container
                sh 'curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -'
                sh 'sudo apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"'
                sh 'sudo apt-get update && sudo apt-get install terraform'
            }
        }
        stages{
        stage('checkout from GIT'){
            steps{
               git branch: 'main', credentialsId: 'github-cred', url: 'https://github.com/yoloxsta/s3_jenkins.git'
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
}
