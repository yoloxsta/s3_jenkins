properties([
    parameters([
        string(
            defaultValue: 'variables.tfvars',
            description: 'Specify the file name',
            name: 'File-Name'
        ),
        choice(
            choices: ['apply', 'destroy'],
            description: 'Select Terraform action',
            name: 'Terraform-Action'
        )
    ])
])

pipeline {
    agent any
    stages {
        stage('Checkout from Git') {
            steps {
                git branch: 'main', url: 'https://github.com/yoloxsta/s3_jenkins.git'
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
                    dir('eks-terraform') {
                        script {
                            sh 'terraform validate'
                        }
                    }
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-key', region: 'us-east-1') {
                    dir('eks-terraform') {
                        script {
                            sh "terraform plan -var-file=${params.'File-Name'}"
                        }
                    }
                }
            }
        }
        stage('Terraform Action') {
            steps {
                withAWS(credentials: 'aws-key', region: 'us-east-1') {
                    script {
                        echo "${params.'Terraform-Action'}"
                        dir('eks-terraform') {
                            script {
                                if (params.'Terraform-Action' == 'apply') {
                                    sh "terraform apply -auto-approve -var-file=${params.'File-Name'}"
                                } else if (params.'Terraform-Action' == 'destroy') {
                                    sh "terraform destroy -auto-approve -var-file=${params.'File-Name'}"
                                } else {
                                    error "Invalid value for Terraform-Action: ${params.'Terraform-Action'}"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
