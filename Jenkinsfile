pipeline {
  agent any

  tools {
    nodejs "Node"
  }

  environment {
    IMAGE_NAME = "my-react-app:${env.BRANCH_NAME}"
  }

  stages {

    stage('Init') {
      steps {
        script {
          // Set port dynamically based on branch name
          env.REACT_APP_PORT = (env.BRANCH_NAME == 'main') ? '3000' : '3001'
        }
      }
    }

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build') {
      steps {
        sh 'chmod +x scripts/build.sh'
        sh 'REACT_APP_PORT=${REACT_APP_PORT} ./scripts/build.sh'
      }
    }

    stage('Test') {
      steps {
        sh 'chmod +x scripts/test.sh'
        sh './scripts/test.sh'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          dockerImage = docker.build("${IMAGE_NAME}")
        }
      }
    }

    stage('Deploy') {
      steps {
        sh """
          docker stop ${env.BRANCH_NAME} || true
          docker rm ${env.BRANCH_NAME} || true
          docker run -d -p ${REACT_APP_PORT}:${REACT_APP_PORT} -e REACT_APP_PORT=${REACT_APP_PORT} --name ${env.BRANCH_NAME} ${IMAGE_NAME}
        """
      }
    }
  }
}
