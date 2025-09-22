pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "franklin11/sample-ecom:latest"
        AWS_REGION = "us-east-1"
    }

    stages {
        stage('Clone') {
            steps {
                git url: 'https://github.com/AlbertFrank11/sample-demo.git', branch: 'main'
            }
        }

        stage('Build Docker') {
            steps {
                sh 'docker build -t sample-ecom .'
            }
        }

        stage('Push Docker') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker tag sample-ecom franklin11/sample-ecom:latest
                        docker push franklin11/sample-ecom:latest
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('infra') {
                    withEnv(["AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID}", "AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY}"]) {
                        sh '''
                            terraform init
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
            }
        }
    }
}

