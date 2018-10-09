#!/bin/bash

echo "create cotd-deploy project"

oc new-project cotd-dev

#deploy two cotd version (cats / cities)

oc new-app openshift/php:5.6~https://github.com/StefanoPicozzi/cotd2.git  --name=cities -e SELECTOR=cities

oc new-app openshift/php:7.1~https://github.com/StefanoPicozzi/cotd2.git  --name=pets -e SELECTOR=pets

#Blue green deployment

oc expose svc/cities -n cotd-dev

oc patch route/bluegreen-example -p '{"spec":{"to":{"name":"example-blue"}}}'
#expose route

oc expose svc/pets --name=cats
oc expose svc/cities --name=cities

#set traffic split

oc set route-backends cities cities=1 pets=1

#see traffic

for i in {1..10}; do curl -s http://$(oc get route cities  --template='{{ .spec.host }}')/item.php | grep "data/images" | awk '{print $5}'; done;