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
      environment {
        tag_version = "${env.BUILD_ID}"
      }

      steps {
        withKubeConfig ([credentialsId: 'kubeconfig']) {
          sh 'sed -i "s/{{TAG}}/$tag_version/g" k8s/deployment.yaml'
          sh 'kubectl apply -f k8s/deployment.yaml'
        }
      }
    }

  }
}
