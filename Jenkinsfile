@Library("jenkins-docker-sharedlibrary") _
    def imageVersion = "${BUILD_ID}"
    dockersharedlib {
        projectName = "Sample Project"
        serverDomain = "Sample Project Server Domain"
        dockerImageName = "nodejs-image-new"
        image = "pavanraj29/nodejs-app"
        node {
        sh "echo ${imageVersion}"
        }
        }
