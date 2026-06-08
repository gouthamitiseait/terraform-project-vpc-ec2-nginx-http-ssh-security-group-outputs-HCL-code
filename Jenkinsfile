pipeline {
    agent any

    stages {

        stage('Pull Code') {
            steps {
                git branch: 'master',
                url: 'https://github.com/gouthamitiseait/terraform-project-vpc-ec2-nginx-http-ssh-security-group-outputs-HCL-code.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-credentials-gouthami', region: 'eu-north-1') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Apply') {
            steps {
                withAWS(credentials: 'aws-credentials-gouthami', region: 'eu-north-1') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo 'EC2 deployment successful'
        }

        failure {
            echo 'EC2 deployment failed'
        }
    }
}
