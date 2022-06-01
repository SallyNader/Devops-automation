pipeline {
    agent any

    stages{
        stage("checkout") {
            steps {
                checkout scm
            }
        }

        stage("deploy") {
            steps {
                sh """
                echo $WORKSPACE
                     scp -o StrictHostKeyChecking=no -rp -i ~/.ssh/id_rsa $WORKSPACE ec2-user@54.83.143.233:/home/ec2-user/k-project

                    ssh -i ~/.ssh/id_rsa ec2-user@54.83.143.233 -o StrictHostKeyChecking=no '
                     ansible-playbook ~/k-project/kubernetes/ansible/deploy-express-app.yaml
                    '

                """
            }
        }

    }
}
