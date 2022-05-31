// Runs terraform to create EC2 instance.
pipeline {
    agent any

    stages {
        stage('checkout') {
            steps {
                checkout scm
            }
        }

        stage('terraform init') {
            steps {
                sh """
                  cd terraform
                  echo "$PWD"
                  terraform init
                """
            }
        }

        stage("terraform apply") {
            steps {

                withCredentials([usernamePassword(credentialsId: 'aws', passwordVariable: 'aws_secret_key', usernameVariable: 'aws_access_key')]) {
                  sh """
                    cd terraform
                    echo "$PWD"
                    terraform apply -var='aws_access_key=${aws_access_key}' -var='aws_secret_key=${aws_secret_key}' -auto-approve 
                  """
                }
                
            }

        }
    }
}
