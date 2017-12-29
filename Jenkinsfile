parameters {
       // string(defaultValue: 'v2', description: '', name: 'buildVersion')
        choice(
            choices: 'Rollingupdate\nBlue-Green\nCanary',
            description: 'Deployment Type',
            name: 'REQUESTED_ACTION')
              }
@Library("jenkins-docker-sharedlibrary") _
    dockersharedlib {
        projectName = "Sample Project"
        serverDomain = "Sample Project Server Domain"
        dockerImageName = "nodejs-image-new"
        image = "pavanraj29/nodejs-app"
        deploymentType = "Rollingupdate"   
        node {
            sh "echo params.REQUESTED_ACTION"
        }
      }
