pipeline {
    agent any
    parameters {
        string(defaultValue: "v1", description: 'build version', name: 'BUILD_VERSION')
        
        choice(choices: 'rollingUpdate\nblueGreenDeploy', description: 'Deployment methodology', name: 'Deployment')
    }

}
