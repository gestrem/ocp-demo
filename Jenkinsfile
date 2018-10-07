node {
        stage ("Build")
            echo '*** Build Starting ***'

            openshiftBuild bldCfg: 'cities', buildName: '', checkForTriggeredDeployments: 'false', commitID: '', namespace: '', showBuildLogs: 'true', verbose: 'true'
            openshiftVerifyBuild bldCfg: 'cities', checkForTriggeredDeployments: 'false', namespace: 'cotd-dev', verbose: 'false'
            echo '*** Build Complete ***'

            
        stage ("Deploy and Verify in Development Env")
            echo '*** Deployment Starting ***'
            openshiftDeploy depCfg: 'cotd2', namespace: '', verbose: 'false', waitTime: ''
            openshiftVerifyDeployment depCfg: 'dc', namespace: 'cotd-dev', replicaCount: '1', verbose: 'false', verifyReplicaCount: 'false', waitTime: ''
            echo '*** Deployment Complete ***'
        }