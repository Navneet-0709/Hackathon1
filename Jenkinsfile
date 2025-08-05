pipeline {
  agent any

  environment {
    DOCKER_IMAGE = 'saiif/todo-app:latest'
    DOCKER_CREDENTIALS_ID = 'dockerhub-creds'
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/Navneet-0709/Hackathon1.git', branch: 'main'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $DOCKER_IMAGE .'
      }
    }

    stage('Push to DockerHub') {
      steps {
        withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", passwordVariable: 'PASS', usernameVariable: 'USER')]) {
          sh 'echo "$PASS" | docker login -u "$USER" --password-stdin'
          sh 'docker push $DOCKER_IMAGE'
        }
      }
    }

stage('Deploy to Docker Swarm') {
  steps {
    sshagent(['Jenkins-agent']) {
      sh '''
        ssh -o StrictHostKeyChecking=no ubuntu@3.92.237.85 << EOF
          echo "Switching to project directory..."
          cd ~/hackathon1

          echo "Removing old stack..."
          docker stack rm todoapp
          sleep 10

          echo "Deploying new stack..."
          docker stack deploy -c docker-compose.yml todoapp
        EOF
      '''
    }
  }
}

