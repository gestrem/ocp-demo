node {
        stage ("Build"){
            echo '*** Build Starting ***'

            openshiftBuild bldCfg: 'cats', buildName: '', checkForTriggeredDeployments: 'false', commitID: '', namespace: '', showBuildLogs: 'false', verbose: 'false'
            openshiftVerifyBuild bldCfg: 'cats', checkForTriggeredDeployments: 'false', namespace: 'cotd-dev', verbose: 'false'


            echo '*** Build Complete ***'
        }

        stage ("Tag Image "){

            openshiftTag(srcStream: 'cats', srcTag: 'latest', destStream: 'cats', destTag: 'stage')


        }
            
        stage ("Deploy and Verify in Test Env"){
            echo '*** Deployment Starting ***'
            openshiftDeploy depCfg: 'cats', namespace: '', verbose: 'false', waitTime: ''
            openshiftVerifyDeployment depCfg: 'cats', namespace: 'cotd-test', replicaCount: '1', verbose: 'false', verifyReplicaCount: 'false', waitTime: ''
            echo '*** Deployment Complete ***'

            }

        stage ("Deploy and Verify in Prod Env"){


            echo '*** Deployment Starting ***'
            echo '*** Waiting for Input ***'
            input 'Should we deploy to Production?' 
            openshiftDeploy depCfg: 'cats', namespace: 'cotd-prod', verbose: 'false', waitTime: ''
            openshiftVerifyDeployment depCfg: 'cats', namespace: 'cotd-dev', replicaCount: '1', verbose: 'false', verifyReplicaCount: 'false', waitTime: ''
            echo '*** Deployment Complete ***'

        }

} 