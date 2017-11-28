pipeline {
    agent any

    parameters {
        string(defaultValue: 'v1', description: '', name: 'userFlag')
    }

    stages {
        stage("buildtest") {
            steps {
                echo "flag: ${params.userFlag}"
                sudo rm -rf node-js-sample
                git clone https://github.com/durgadeviramadoss/node-js-sample.git
            }
        }
    }
}
