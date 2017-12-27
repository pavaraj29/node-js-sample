imageVersion = ${BUILD_ID}
@Library("jenkins-docker-sharedlibrary") _
    dockersharedlib {
        projectName = "Sample Project"
        serverDomain = "Sample Project Server Domain"
        dockerImageName = "nodejs-image-new"
        image = "pavanraj29/nodejs-app"
        node {
        sh "echo ${imageVersion}"
        }
        }
