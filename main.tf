pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
    - name: terraform
      image: hashicorp/terraform:latest
      command: ['cat']
      tty: true
      env:
        - name: AWS_ACCESS_KEY_ID
          valueFrom:
            secretKeyRef:
              name: aws-credentials
              key: AWS_ACCESS_KEY_ID
        - name: AWS_SECRET_ACCESS_KEY
          valueFrom:
            secretKeyRef:
              name: aws-credentials
              key: AWS_SECRET_ACCESS_KEY
"""
        }
    }

    environment {
        TF_VAR_region = 'us-east-1'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', credentialsId: 'github-cred', url: 'https://github.com/YOUR_GITHUB_USERNAME/s3_jenkins.git'
            }
        }

        stage('Terraform Init') {
            steps {
                container('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                container('terraform') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                container('terraform') {
                    sh 'terraform apply --auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo 'S3 bucket deployed successfully!'
        }
        failure {
            echo 'Terraform deployment failed.'
        }
    }
}
