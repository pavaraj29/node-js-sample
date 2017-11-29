pipeline {
    agent any

    parameters {
        string(defaultValue: 'v2', description: '', name: 'buildVersion')
        choice(
            choices: 'Rollingupdate\nBlue-Green',
            description: 'Deployment Type',
            name: 'REQUESTED_ACTION')
    }
    environment {
    // Environment variable identifiers need to be both valid bash variable
    // identifiers and valid Groovy variable identifiers. If you use an invalid
    // identifier, you'll get an error at validation time.
    // Right now, you can't do more complicated Groovy expressions or nesting of
    // other env vars in environment variable values, but that will be possible
    // when https://issues.jenkins-ci.org/browse/JENKINS-41748 is merged and
    // released.
    account = "958306274796"
    service = "my-service"
    deployment = "nodejs"
    DEPLOYMENTFILE = "deploy-green.yml"
    VERSION= "${BUILD_ID}"
     }
    
    stages {
        stage("build") {
            steps {
                echo "${params.buildVersion}"
                sh 'sudo rm -rf node-js-sample'
                sh 'git clone https://github.com/durgadeviramadoss/node-js-sample.git'
            }
        }
        stage("Docker image build") {
            steps {
                sh 'cd node-js-sample &&  sudo docker build -t nodejs-image-new .'
            }
        }
        stage("Docker image tag") {
            steps {
                sh 'echo $(aws ecr get-login --region us-east-1 --registry-ids ${account}) > file.txt'
                sh 'sudo $( sed "s/-e none//g" file.txt)'
                sh "sudo  docker tag nodejs-image-new ${env.account}.dkr.ecr.us-east-1.amazonaws.com/demo-jenkins-pipeline:nodejs-image-${env.VERSION}"
            }
        }
        stage("Docker image push") {
            steps {
                sh "sudo docker push ${env.account}.dkr.ecr.us-east-1.amazonaws.com/demo-jenkins-pipeline:nodejs-image-${env.VERSION}"
            }
        }
         stage("Rollingupdate Deployment") {
             when {
                // Only say hello if a "greeting" is requested
                expression { params.REQUESTED_ACTION == 'Rollingupdate' }
            }
            steps {
                sh 'kubectl patch svc ${deployment} -p $"spec:\n   containers:\n   - name: front-end\n     image: ${env.account}.dkr.ecr.us-east-1.amazonaws.com/demo-jenkins-pipeline:nodejs-image-${env.VERSION}"'
            }
        }
        stage("Blue-green Deployment") {
            when {
                // Only say hello if a "greeting" is requested
                expression { params.REQUESTED_ACTION == 'Blue-Green' }
            }
            steps {
                sh 'kubectl apply -f ${DEPLOYMENTFILE}'
                sh 'kubectl patch svc ${service} -p $"spec:\n selector:\n  - app: nodeapp\n    version: "${VERSION}""'
            }
        }
    }
    
}
