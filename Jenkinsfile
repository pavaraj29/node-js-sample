@Library("jenkins-docker-sharedlibrary") _
    dockersharedlib {
        projectName = "Sample Project"
        serverDomain = "Sample Project Server Domain"
        dockerImageName = "nodejs-image-new"
        image = "pavanraj29/nodejs-app"
        environment {
            imageVersion = "${env.BUILD_ID}"
        }
        node {
        sh "echo ${imageVersion}"
        }
        }
