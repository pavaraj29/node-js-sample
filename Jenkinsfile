//def imageVersion = "${BUILD_ID}"
environment{
    imageVersion = currentBuild.getNumber()
}
@Library("jenkins-docker-sharedlibrary") _
    dockersharedlib {
        projectName = "Sample Project"
        serverDomain = "Sample Project Server Domain"
        dockerImageName = "nodejs-image-new"
        image = "pavanraj29/nodejs-app"
        node {
        sh "export imageVersion='${imageVersion}'"
        }
        }
