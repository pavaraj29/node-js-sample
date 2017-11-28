def aws_creds = '4204626e-9b16-448b-9b2b-689e485be918'
pipeline {
    agent any

    parameters {
        string(defaultValue: 'v1', description: '', name: 'buildVersion')
    }
   withCredentials([
      [$class: 'UsernamePasswordMultiBinding', credentialsId: aws_creds, usernameVariable: 'AWS_USER', passwordVariable: 'AWS_PASS'],
  ]){
    stage ('echo variables') {
      sh """(
        echo "User: ${AWS_USER}"
        echo "Pass: ${AWS_PASS}"
      )"""
    }
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
                sh 'echo $(aws ecr get-login --region us-east-1 --registry-ids 958306274796) > file.txt'
                sh 'sudo $( sed "s/-e none//g" file.txt)'
                sh "sudo  docker tag nodejs-image-new 958306274796.dkr.ecr.us-east-1.amazonaws.com/demo-jenkins-pipeline:nodejs-image-${params.buildVersion}"
            }
        }
        stage("Docker image push") {
            steps {
                sh "sudo docker push 958306274796.dkr.ecr.us-east-1.amazonaws.com/demo-jenkins-pipeline:nodejs-image-${params.buildVersion}"
            }
        }
    }
    
}
