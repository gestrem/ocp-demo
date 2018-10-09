node {
        stage ("Build"){
            echo '*** Build Starting ***'

            openshiftBuild bldCfg: 'cotd', buildName: '', checkForTriggeredDeployments: 'false', commitID: '', namespace: '', showBuildLogs: 'false', verbose: 'false'
            openshiftVerifyBuild bldCfg: 'cotd', checkForTriggeredDeployments: 'false', namespace: 'cotd-dev', verbose: 'false'


            echo '*** Build Complete ***'
        }

        stage ("Tag Image"){

            openshiftTag(srcStream: 'cotd', srcTag: 'latest', destStream: 'cotd', destTag: 'stage')


        }
            
        stage ("Deploy and Verify in Test Env"){
            echo '*** Deployment Starting ***'
            openshiftDeploy depCfg: 'cotd', namespace: 'cotd-test', verbose: 'false', waitTime: ''
            openshiftVerifyDeployment depCfg: 'cotd', namespace: 'cotd-test', replicaCount: '1', verbose: 'false', verifyReplicaCount: 'false', waitTime: ''
            echo '*** Deployment Complete ***'

            }

        stage ("Deploy and Verify in Prod Env"){


            echo '*** Deployment Starting ***'
            echo '*** Waiting for Input ***'
            input 'Should we deploy to Production?' 
            openshiftDeploy depCfg: 'cotd', namespace: 'cotd-prod', verbose: 'false', waitTime: ''
            openshiftVerifyDeployment depCfg: 'cotd', namespace: 'cotd-prod', replicaCount: '1', verbose: 'false', verifyReplicaCount: 'false', waitTime: ''
            echo '*** Deployment Complete ***'

        }

} 