pipeline {
  agent any
  environment {
    REACT_APP_PORT = (env.BRANCH_NAME == 'main') ? '3000' : '3001'
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build') {
      steps {
        sh './scripts/build.sh'
      }
    }

    stage('Test') {
      steps {
        sh './scripts/test.sh'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          dockerImage = docker.build("my-app:${env.BRANCH_NAME}")
        }
      }
    }

    stage('Deploy') {
      steps {
        sh "docker run -d -p ${REACT_APP_PORT}:${REACT_APP_PORT} --name app-${env.BRANCH_NAME} -e REACT_APP_PORT=${REACT_APP_PORT} my-app:${env.BRANCH_NAME}"
      }
    }
  }
}