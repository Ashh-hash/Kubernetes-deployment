pipeline {
  agent any

  environment {
    ACR_NAME = 'codecraftacr.azurecr.io'
    IMAGE_NAME = 'taskapi'
    IMAGE_TAG = 'latest'
    RESOURCE_GROUP = 'codecraft-rg'
    CLUSTER_NAME = 'codecraft-aks'
  }

  stages {
    stage('Checkout Code') {
      steps {
        node {
          git 'https://github.com/your-username/CodeCraft-DevOps-Project.git'
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        node {
          dir('app') {
            sh "docker build -t ${ACR_NAME}/${IMAGE_NAME}:${IMAGE_TAG} ."
          }
        }
      }
    }

    stage('Login to ACR') {
      steps {
        node {
          sh "az acr login --name codecraftacr"
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        node {
          sh "docker push ${ACR_NAME}/${IMAGE_NAME}:${IMAGE_TAG}"
        }
      }
    }

    stage('Deploy to AKS') {
      steps {
        node {
          sh "az aks get-credentials --resource-group ${RESOURCE_GROUP} --name ${CLUSTER_NAME}"
          sh "kubectl apply -f k8s/deployment.yaml"
          sh "kubectl apply -f k8s/service.yaml"
        }
      }
    }
  }
}
