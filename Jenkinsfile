node {
   echo 'Hello World'
   git credentialsId: '9010883c-bf76-4a03-9fad-52550ce537b2', url: 'https://github.com/durgadeviramadoss/node-js-sample.git'
   
    stage 'Build'
        sh '[ -d "node-js-sample" ] && sudo rm -rf node-js-sample'
        sh 'git clone https://github.com/durgadeviramadoss/node-js-sample.git'
    
    stage 'Docker image build'
        sh 'sudo docker build -t nodejs-image-new .'
        
    stage 'Docker image tag'
        sh 'echo $(aws ecr get-login --region us-east-1 --registry-ids 958306274796) > file.txt'
        sh 'sudo $( sed "s/-e none//g" file.txt)'
        sh 'sudo  docker tag nodejs-image-new 958306274796.dkr.ecr.us-east-1.amazonaws.com/demo-jenkins-pipeline:nodejs-image-new-v1'
    
    stage 'Docker image push'
        sh 'sudo docker push 958306274796.dkr.ecr.us-east-1.amazonaws.com/demo-jenkins-pipeline:nodejs-image-new-v1'

    stage 'Kubernetes Deploy'
        sh 'kubectl create -f service.yml'
        sh 'kubectl create -f deploy.yml'
        sh 'kubectl get pods'
}
