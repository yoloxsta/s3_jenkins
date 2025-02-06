pipeline {
    agent {
        kubernetes {
            label 'terraform-agent'
            defaultContainer 'terraform'
            yaml """
apiVersion: v1
kind: Pod
metadata:
  namespace: jenkins
  labels:
    agent: terraform
spec:
  containers:
    - name: terraform
      image: hashicorp/terraform:latest
      command: ['sleep', 'infinity']
"""
        }
    }

    environment {
        AWS_CREDENTIALS = credentials('aws-key')  // Fetch AWS credentials
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github-cred', url: 'https://github.com/yoloxsta/s3_jenkins.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -var="aws_access_key=${AWS_CREDENTIALS_USR}" -var="aws_secret_key=${AWS_CREDENTIALS_PSW}"'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve -var="aws_access_key=${AWS_CREDENTIALS_USR}" -var="aws_secret_key=${AWS_CREDENTIALS_PSW}"'
            }
        }
    }
}
