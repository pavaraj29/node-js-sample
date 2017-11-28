pipeline {
    agent any

    parameters {
        string(defaultValue: 'v1', description: '', name: 'userFlag')
    }

    stages {
        stage("buildtest") {
            steps {
                echo "flag: ${params.userFlag}"
            }
        }
    }
}
