import groovy.json.JsonOutput
def payload = JsonOutput.toJson([jobname: "${env.JOB_NAME}",
        buildno: "${BUILD_ID}",
        stauts: "Success"
    ])
def slackURL = 'https://hooks.slack.com/services/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'
pipeline {
    agent any

    parameters {
       // string(defaultValue: 'v2', description: '', name: 'buildVersion')
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
    image = "${env.account}.dkr.ecr.us-east-1.amazonaws.com/demo-jenkins-pipeline:nodejs-image-${env.VERSION}"
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
                sh 'sudo  docker tag nodejs-image-new ${image}'
            }
        }
        stage("Docker image push") {
            steps {
                sh 'sudo docker push ${image}'
            }
        }
        stage("Image scanning"){
            steps{
                sh '''
                    [ -d "clair-config" ] && sudo rm -rf clair-config
                    sudo mkdir clair-config
                    sudo curl -L https://raw.githubusercontent.com/coreos/clair/master/config.yaml.sample -o $PWD/clair-config/config.yaml 
                    IPADDRESS=`hostname -I | awk '{print $1}'`
                    sudo sed -e "s/localhost/$IPADDRESS/g" -i $PWD/clair-config/config.yaml
                    '''
                sh '''
                    sudo curl -LO https://github.com/optiopay/klar/releases/download/v1.5-RC2/klar-1.5-RC2-linux-amd64
                    sudo chmod +x klar-1.5-RC2-linux-amd64
                    sudo mv klar-1.5-RC2-linux-amd64 /usr/local/bin/klar 
                    echo $(aws ecr get-login --region us-east-1 --registry-ids ${account}) > file.txt
                    PASSWORD=$(sed "s/-e none//g" file.txt | cut -d' ' -f6)
                    CLAIR_ADDR=localhost DOCKER_USER=AWS DOCKER_PASSWORD=${PASSWORD} klar ${image} || exit 0
                    '''
            }
        }
        stage("Build Notification") {
           steps {  
                   sh 'echo $payload'
                   slackSend (color: '#FFFF00', message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
                   //sh "curl -X POST -H 'Content-type: application/json' --data '{"text":"Success"}' https://hooks.slack.com/services/T87HA5CE6/B88KQ659V/gR22o9XK5PioXyDhy035Q7"
            }
        }
     }  
}

