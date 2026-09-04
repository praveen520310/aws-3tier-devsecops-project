```groovy
pipeline {
    agent any

    parameters {
        choice(
            name: 'ACTION',
            choices: ['DEPLOY', 'DESTROY'],
            description: 'Choose whether to deploy or destroy the Terraform infrastructure.'
        )
    }

    environment {
        TF_DIR = 'environments/dev'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            when {
                expression {
                    params.ACTION == 'DEPLOY'
                }
            }
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            when {
                expression {
                    params.ACTION == 'DEPLOY'
                }
            }
            steps {
                withCredentials([
                    string(credentialsId: 'terraform-db-password', variable: 'TF_VAR_db_password'),
                    string(credentialsId: 'terraform-sns-email', variable: 'TF_VAR_sns_email')
                ]) {
                    dir("${TF_DIR}") {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Deploy Approval') {
            when {
                expression {
                    params.ACTION == 'DEPLOY'
                }
            }
            steps {
                input message: 'Terraform plan completed. Do you want to APPLY the infrastructure?',
                      ok: 'Apply'
            }
        }

        stage('Terraform Apply') {
            when {
                expression {
                    params.ACTION == 'DEPLOY'
                }
            }
            steps {
                withCredentials([
                    string(credentialsId: 'terraform-db-password', variable: 'TF_VAR_db_password'),
                    string(credentialsId: 'terraform-sns-email', variable: 'TF_VAR_sns_email')
                ]) {
                    dir("${TF_DIR}") {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
        }

        stage('Terraform Destroy Plan') {
            when {
                expression {
                    params.ACTION == 'DESTROY'
                }
            }
            steps {
                withCredentials([
                    string(credentialsId: 'terraform-db-password', variable: 'TF_VAR_db_password'),
                    string(credentialsId: 'terraform-sns-email', variable: 'TF_VAR_sns_email')
                ]) {
                    dir("${TF_DIR}") {
                        sh 'terraform plan -destroy -out=tfplan-destroy'
                    }
                }
            }
        }

        stage('Destroy Approval') {
            when {
                expression {
                    params.ACTION == 'DESTROY'
                }
            }
            steps {
                input message: 'WARNING: This will destroy the Terraform infrastructure. Continue?',
                      ok: 'Destroy'
            }
        }

        stage('Terraform Destroy') {
            when {
                expression {
                    params.ACTION == 'DESTROY'
                }
            }
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform apply -auto-approve tfplan-destroy'
                }
            }
        }
    }

    post {
        success {
            echo "Terraform ${params.ACTION} completed successfully."
        }

        failure {
            echo "Terraform ${params.ACTION} pipeline failed."
        }
    }
}
```
