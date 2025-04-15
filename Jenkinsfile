pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = 'codecraftacr.azurecr.io'
        IMAGE_NAME = 'codecraft-api'
        IMAGE_TAG = "${BUILD_NUMBER}"
        KUBE_CONFIG = credentials('kube-config')
        ACR_CREDENTIALS = credentials('acr-credentials')
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build .NET Application') {
            steps {
                dir('app') {
                    sh 'dotnet build --configuration Release'
                    sh 'dotnet test --no-build'
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                dir('app') {
                    sh """
                        docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} .
                        docker tag ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest
                    """
                }
            }
        }
        
        stage('Push to Container Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'acr-credentials', usernameVariable: 'ACR_USERNAME', passwordVariable: 'ACR_PASSWORD')]) {
                    sh """
                        docker login ${DOCKER_REGISTRY} -u ${ACR_USERNAME} -p ${ACR_PASSWORD}
                        docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}
                        docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest
                    """
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kube-config', variable: 'KUBECONFIG')]) {
                    sh """
                        export KUBECONFIG=${KUBECONFIG}
                        kubectl apply -f k8s/
                        kubectl set image deployment/codecraft-api codecraft-api=${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
} 