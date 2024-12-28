pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "ic-webapp"
        DOCKER_TAG = "1.0"
        DOCKER_HUB = "bostel"
    }
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
            }
        }
        stage('Test') {
            steps {
                sh 'docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} python -m unittest discover tests'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-credentials', variable: 'DOCKER_PASSWORD')]) {
                    sh """
                    echo "$DOCKER_PASSWORD" | docker login -u ${DOCKER_HUB} --password-stdin
                    docker push ${DOCKER_HUB}/${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }
        stage('Deploy with Ansible') {
            steps {
                sh 'ansible-playbook -i inventory deploy.yml'
            }
        }
    }
}
