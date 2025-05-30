# Docker-web-image

To write a **Jenkins Pipeline script** in a `README.md` file, use **Markdown fenced code blocks** with syntax highlighting for **Groovy**, since Jenkins pipelines are written in Groovy.

---

### ✅ Example: Markdown Format for Jenkins Pipeline

````markdown
## 🛠️ Jenkins Declarative Pipeline

Below is an example Jenkins pipeline that remove Docker container and image:

```groovy
pipeline {
    agent any

    tools {
       dockerTool 'docker'
    }


    environment {
        GIT_REPO = 'https://github.com/techpentest/Docker-web-image.git'
        IMAGE_NAME = 'testlab/app1'
        CONTAINER_NAME = 'web-container'
    }

    stages {
        stage('Clone GitHub Repository') {
            steps {
                git branch: 'main', url: "${env.GIT_REPO}"
            }
        }
        
        stage('Check Running Docker container') {
            steps {
                sh "sudo -S docker ps -a"
            }
        }

        stage('Stop and Remove Running Docker Container') {
            steps {
                script {
                    sh '''
                    sudo -S docker stop ${CONTAINER_NAME} || true
                    sudo -S docker rm ${CONTAINER_NAME} || true
                    '''
                }
            }
        }
        
         stage('Check Docker Images') {
            steps {
                sh "sudo -S docker images"
            }
        }
        
        stage('Remove Docker Images') {
            steps {
                script{
                    sh "sudo -S docker rmi --force ${IMAGE_NAME}:${env.BUILD_NUMBER} || true"
                }
            }
        }
    }

    post {
        success {
            echo "Application destroyed successfully."
        }
        failure {
            echo "Deployment failed. Check logs."
        }
    }
}
````
