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

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github-cred', url: 'https://github.com/yoloxsta/s3_jenkins.git'
            }
        }
        stage('configure aws credentials') {
            steps {
                withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                credentialsId: 'aws-key']]) 
                {
                    script 
                    {
                        sh 'aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID'
                        sh 'aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY'
                        sh 'terraform init'
                        sh 'terraform plan'
                    }
                }
            }
        }
    }
}

//         stage('Terraform Init') {
//             steps {
//                 sh 'terraform init'
//             }
//         }

//         stage('Terraform Plan') {
//             steps {
//                 sh 'terraform plan -var="aws_access_key=${AWS_CREDENTIALS_USR}" -var="aws_secret_key=${AWS_CREDENTIALS_PSW}"'
//             }
//         }

//         stage('Terraform Apply') {
//             steps {
//                 sh 'terraform apply -auto-approve -var="aws_access_key=${AWS_CREDENTIALS_USR}" -var="aws_secret_key=${AWS_CREDENTIALS_PSW}"'
//             }
//         }
//     }
// }
