#!/bin/bash

echo "Promote Images"

oc tag cities:latest cities:stage -n cotd-dev

oc tag cities:stage cotd2:prod -n cotd-dev

#deploy two cotd version (cats / cities)

oc new-app openshift/php:5.6~https://github.com/StefanoPicozzi/cotd2.git  --name=cities -e SELECTOR=cities

oc new-app openshift/php:7.1~https://github.com/StefanoPicozzi/cotd2.git  --name=pets -e SELECTOR=pets

#expose route

oc expose svc/pets --name=cats
oc expose svc/cities --name=cities

#set traffic split

oc set route-backends cities cities=1 pets=1

#see traffic

for i in {1..10}; do curl -s http://$(oc get route cities  --template='{{ .spec.host }}')/item.php | grep "data/images" | awk '{print $5}'; done;