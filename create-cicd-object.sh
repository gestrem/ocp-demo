#!/bin/bash

echo "create cotd-test project "
oc new-project cotd-test --description="Cat of the Day Development Environment" --display-name="Cat Of The Day - test"
echo "create cotd-prod project "
oc new-project cotd-prod --description="Cat of the Day Development Environment" --display-name="Cat Of The Day - prod"



echo "Enable Jenkins service account to manage resources in test and Project"
oc policy add-role-to-user edit system:serviceaccount:cicd-tools:jenkins -n cotd-test
oc policy add-role-to-user edit system:serviceaccount:cicd-tools:jenkins -n cotd-prod

echo "Enable the pulling of images from dev to test and prod "

oc policy add-role-to-group system:image-puller system:serviceaccounts:cotd-test -n cotd-dev
oc policy add-role-to-group system:image-puller system:serviceaccounts:cotd-prod -n cotd-dev




