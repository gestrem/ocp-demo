#disable automatic deploymlent

oc get dc cats -o yaml -n cotd-dev | sed 's/automatic: true/automatic: false/g' | oc replace -f -
oc get dc cats -o yaml -n cotd-test | sed 's/automatic: true/automatic: false/g' | oc replace -f -
oc get dc cats -o yaml -n cotd-prod | sed 's/automatic: true/automatic: false/g' | oc replace -f -

