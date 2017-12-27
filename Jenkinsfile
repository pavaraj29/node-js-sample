@Library("jenkins-docker-sharedlibrary") _
    def buildNo = ${BUILD_NUMBER}
    dockersharedlib {
        projectName = "Sample Project"
        serverDomain = "Sample Project Server Domain"
        dockerImageName = "nodejs-image-new"
        image = "pavanraj29/nodejs-app"
        imageVersion = buildNo
        }
