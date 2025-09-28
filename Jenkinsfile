pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                def customImage = docker.build("giannidylancbhg/scheduler-app:{env.BUILD_ID}")
                customImage.push()
            }
        }
    }
}