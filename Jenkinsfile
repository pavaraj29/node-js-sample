import hudson.model.ParameterValue;
import hudson.model.ParametersAction;
node {
        /**
         * Use currentBuild to:
         * -Retrieve the build parameters
         * -Display all the build parameters
         */
        def myBuildParams = currentBuild.rawBuild.getAction(ParametersAction.class)
        for(ParameterValue p in myBuildParams) {
            println p.name
            println p.value
        }
}
