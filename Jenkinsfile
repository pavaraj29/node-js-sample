node {
   echo 'Hello World1'

   parameters {
        choice(name: 'DEPLOYMENT_TYPE', choices: 'rollingUpdate\nblueGreenDeployment', description: 'Deployment Type')
   }
   parameters {
        string(name: 'BUILD_VERSION', defaultValue: 'v1', description: 'Version of the build')
   }
      
}
