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
                     scp -o StrictHostKeyChecking=no -rp -i ~/.ssh/id_rsa $WORKSPACE/kubernetes ec2-user@3.80.37.193:/home/ec2-user/k-project

                    ssh -i ~/.ssh/id_rsa ec2-user@3.80.37.193 -o StrictHostKeyChecking=no '
                     ansible-playbook ~/k-project/ansible/deploy-express-app.yaml
                    '

                """
            }
        }

    }
}
