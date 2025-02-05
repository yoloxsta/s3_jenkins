// properties([
//     parameters([
//         string(
//             defaultValue: 'variables.tfvars',
//             description: 'Specify the file name',
//             name: 'File-Name'
//         ),
//         choice(
//             choices: ['apply', 'destroy'],
//             description: 'Select Terraform action',
//             name: 'Terraform-Action'
//         )
//     ])
// ])

pipeline {
    agent any {
            docker {
            image 'hashicorp/terraform:latest' // Ensure this image is being used // Optional if you need Docker in Docker
        }
    }
    stages{
        stage('Checkout from Git') {
            steps {
                git branch: 'main', url: 'https://github.com/yoloxsta/s3_jenkins.git'
            }
        }
        stage('Check Terraform Version') {
             steps {
                     script {
                        sh 'terraform -version'
        }
    }
}

        stage('Initializing Terraform') {
            steps {
                withAWS(credentials: 'aws-key', region: 'us-east-1') {
                    script {
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Validate Terraform Code') {
            steps {
                withAWS(credentials: 'aws-key', region: 'us-east-1') {
                        script {
                            sh 'terraform validate'
                        }
                    }
                }
            }
        
        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-key', region: 'us-east-1') {
                        script {
                            sh "terraform plan -var-file=${params.'File-Name'}"
                        }
                    }
                }
            }
        stage('Terraform Action') {
            steps {
                withAWS(credentials: 'aws-key', region: 'us-east-1') {
                        script {
                            sh "terraform plan -var-file=${params.'File-Name'}"
                
                 }
             }
         }
     }

   }
}