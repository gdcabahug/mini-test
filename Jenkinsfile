pipeline {
    agent any

    environment {
        IMAGE = "gdcabahug/scheduler-app"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Build and push Docker image
                    def customImage = docker.build("${IMAGE}:${env.BUILD_ID}")
                    customImage.push()
                }
            }
        }
    }
}