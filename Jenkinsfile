pipeline {
    agent any

    environment {
        IMAGE = "gdcabahug/scheduler-app"
        REGISTRY = "https://index.docker.io/v1/"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Build and push Docker image
                    def customImage = docker.build("${IMAGE}:${env.BUILD_ID}-${env.GIT_COMMIT.take(7)}")
                    docker.withRegistry("${REGISTRY}", "docker-hub-cred") {
                        customImage.push()
                    }
                }
            }
        }
    }
}