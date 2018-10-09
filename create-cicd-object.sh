#!/bin/bash

echo "create cotd-test project "
oc new-project cotd-test --description=" 2. Cat of the Day Test Environment" --display-name="2. Cat Of The Day - test"
echo "create cotd-prod project "
oc new-project cotd-prod --description="3. Cat of the Day Prod Environment" --display-name="3. Cat Of The Day - prod"



echo "Enable Jenkins service account to manage resources in test and Project"
oc policy add-role-to-user edit system:serviceaccount:cicd-tools:jenkins -n cotd-test
oc policy add-role-to-user edit system:serviceaccount:cicd-tools:jenkins -n cotd-prod
oc policy add-role-to-user edit system:serviceaccount:cotd-dev:jenkins -n cotd-prod

echo "Enable the pulling of images from dev to test and prod "

oc policy add-role-to-group system:image-puller system:serviceaccounts:cotd-test -n cotd-dev
oc policy add-role-to-group system:image-puller system:serviceaccounts:cotd-prod -n cotd-dev



echo "Deploy App from Registry"

oc new-app cotd-dev/cats:latest --name=cats -n cotd-test
oc new-app cotd-dev/cats:latest --name=cats -n cotd-prod

oc expose svc/cats -n cotd-test
oc expose svc/cats -n cotd-prod



#oc policy add-role-to-group  edit system:serviceaccount:cotd-dev:jenkins -n cotd-prod