pipeline {
    agent any

    parameters {
       // string(defaultValue: 'v2', description: '', name: 'buildVersion')
        choice(
            choices: 'Rollingupdate\nBlue-Green\nCanary',
            description: 'Deployment Type',
            name: 'REQUESTED_ACTION')
    }
    
    stages {
        
        stage("Rollingupdate Deployment") {
             when {
                // Only say hello if a "greeting" is requested
                expression { params.REQUESTED_ACTION == 'Rollingupdate' }
            }
            steps {
                sh 'echo Hello'
                sh 'kubectl patch deployment ${deployment} -p $"spec:\n   containers:\n   - name: front-end\n     image: ${image}"'
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
        stage("Canary Deployment") {
            when {
                // Only say hello if a "greeting" is requested
                expression { params.REQUESTED_ACTION == 'Canary' }
            }
            steps {
                sh '''
                        kubectl apply -f deploy-canary.yaml
                        sleep 60
                        SERVICE_IP=`kubectl get svc my-service -o jsonpath="{.status.loadBalancer.ingress[0].*}"`
                        for i in `seq 1 10`; do curl http://$SERVICE_IP/>>tmpfile; sleep 1;  done
                        if grep -q "Hello World-v2" "tmpfile"; then 
                        kubectl set image deployment/nodejs front-end=pavanraj29/nodejs-app:v2
                        fi
                        rm tmpfile
                '''
            }
        }
     }  
}
