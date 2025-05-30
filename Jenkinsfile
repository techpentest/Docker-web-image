pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/techpentest/Docker-web-image.git'
        IMAGE_NAME = 'testlab/app1'
        CONTAINER_NAME = 'web-container'
    }

    stages {
        stage('Install Docker (if missing)') {
            steps {
                sh '''
                if ! command -v docker > /dev/null; then
                    echo "Docker not found. Installing Docker..."
                    curl -fsSL https://get.docker.com -o get-docker.sh
                    sudo sh get-docker.sh
                    sudo usermod -aG docker $USER
                    newgrp docker
                else
                    echo "Docker is already installed."
                fi
                '''
            }
        }

        stage('Clone GitHub Repository') {
            steps {
                git branch: 'main', url: "${env.GIT_REPO}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh '''
                    sudo docker stop ${CONTAINER_NAME} || true
                    sudo docker rm ${CONTAINER_NAME} || true
                    sudo docker run -d --name ${CONTAINER_NAME} -p 80:80 ${IMAGE_NAME}:${BUILD_NUMBER}
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Application deployed successfully."
        }
        failure {
            echo "Deployment failed. Check logs."
        }
    }
}
