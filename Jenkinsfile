pipeline {
  agent any

  stages {
    stage ('Build Image') {
      steps {
        script {
          dockerapp = docker.build("machadoluiz/kube-news:${env.BUILD_ID}", "-f Dockerfile .")
        }
      }
    }

    stage ('Push Image') {
      steps {
        script {
          docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
            dockerapp.push()
            dockerapp.push("${env.BUILD_ID}")
          dockerapp.push('latest')
          }
        }
      }
    }

    stage ('Deploy App') {
      steps {
        withKubeConfig ([credentialsId: 'kubeconfig']) {
          sh 'sed -i "s/{{TAG}}/${env.BUILD_ID}/g" k8s/deployment.yaml'
          sh 'kubectl apply -f k8s/deployment.yaml'
        }
      }
    }

  }
}
