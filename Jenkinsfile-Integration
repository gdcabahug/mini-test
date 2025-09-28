pipeline {
    agent any

    environment {
        IMAGE = 'gdcabahug/scheduler-app'
        REGISTRY = 'https://index.docker.io/v1/'
    }

    stages {
        stage('Build') {
            // Only run this stage if Dockerfile or scheduler.sh has changed
            when {
                anyOf {
                    changeset 'Dockerfile'
                    changeset 'scheduler.sh'
                }
            }
            steps {
                script {
                    // Build and push Docker image
                    def customImage = docker.build("${IMAGE}:${env.BUILD_ID}-${env.GIT_COMMIT.take(7)}")
                    docker.withRegistry("${REGISTRY}", 'docker-hub-cred') {
                        customImage.push()
                    }
                }
            }
        }
    }
}
