def acc //undefined shared variable
pipeline {
    agent any

    parameters {
        string(defaultValue: 'v1', description: '', name: 'buildVersion')
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
                sh 'cd node-js-sample'
                script{
                    acc = $(cat account)
                }
                sh 'echo ${acc}'
                sh 'echo $(aws ecr get-login --region us-east-1 --registry-ids ${acc}) > file.txt'
                sh 'sudo $( sed "s/-e none//g" file.txt)'
                sh "sudo  docker tag nodejs-image-new ${acc}.dkr.ecr.us-east-1.amazonaws.com/demo-jenkins-pipeline:nodejs-image-${params.buildVersion}"
            }
        }
        stage("Docker image push") {
            steps {
                sh "sudo docker push ${acc}.dkr.ecr.us-east-1.amazonaws.com/demo-jenkins-pipeline:nodejs-image-${params.buildVersion}"
            }
        }
    }
    
}
