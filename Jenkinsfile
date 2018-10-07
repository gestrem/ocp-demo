node {
        stage ("Build"){
            echo '*** Build Starting ***'

            openshiftBuild bldCfg: 'cities', buildName: '', checkForTriggeredDeployments: 'false', commitID: '', namespace: '', showBuildLogs: 'false', verbose: 'false'
            openshiftVerifyBuild bldCfg: 'cities', checkForTriggeredDeployments: 'false', namespace: 'cotd-dev', verbose: 'false'


            echo '*** Build Complete ***'
        }

        stage ("Tag Image "){

            openshiftTag(srcStream: 'cities', srcTag: 'latest', destStream: 'cities', destTag: 'stage')


        }
            
        stage ("Deploy and Verify in Development Env"){
            echo '*** Deployment Starting ***'
            openshiftDeploy depCfg: 'cities', namespace: '', verbose: 'false', waitTime: ''
            openshiftVerifyDeployment depCfg: 'cities', namespace: 'cotd-dev', replicaCount: '1', verbose: 'false', verifyReplicaCount: 'false', waitTime: ''
            echo '*** Deployment Complete ***'

            }

        stage ("Deploy and Verify in Test Env"){


            echo '*** Deployment Starting ***'
            openshiftDeploy depCfg: 'cities', namespace: 'cotd-prod', verbose: 'false', waitTime: ''
            openshiftVerifyDeployment depCfg: 'cities', namespace: 'cotd-dev', replicaCount: '1', verbose: 'false', verifyReplicaCount: 'false', waitTime: ''
            echo '*** Deployment Complete ***'

        }