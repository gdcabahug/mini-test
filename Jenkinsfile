pipeline {
    agent any

    environment {
        IMAGE = 'gdcabahug/scheduler-app'
        REGISTRY = 'https://index.docker.io/v1/'
    }

    stages {
        // Build Stage
        stage('Build Application') {
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
                    // def customImage = docker.build("${IMAGE}:${env.BUILD_ID}-${env.GIT_COMMIT.take(7)}")
                    // def customImage = docker.build("${IMAGE}:${env.GIT_COMMIT.take(7)}")
                    sh "docker build --network=host -t gdcabahug/scheduler-app:${GIT_COMMIT.take(7)} ."
       
                    docker.withRegistry("${REGISTRY}", 'docker-hub-cred') {
                        // customImage.push()
                        // customImage.push("latest")
                        sh "docker push gdcabahug/scheduler-app:${GIT_COMMIT.take(7)}"
                        sh "docker tag gdcabahug/scheduler-app:${GIT_COMMIT.take(7)} gdcabahug/scheduler-app:latest"
                        sh "docker push gdcabahug/scheduler-app:latest"
                    }
         
                }
            }
        }

        // Deploy Stage
        stage('Deploy Application') {
            // Only run this stage if Dockerfile or scheduler.sh has changed
            when {
                anyOf {
                    changeset 'Dockerfile'
                    changeset 'scheduler.sh'
                }
            }

            steps {
                withKubeConfig([credentialsId: 'kube-cred']) {
                    sh "kubectl delete deploy scheduler-deployment || true"
                    sh "kubectl apply -f test-manifests/deploy-test.yml"
                }
            }
        }
    }
}
