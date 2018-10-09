#!/bin/bash

echo "create cotd-deploy project"

oc new-project cotd-dev

#deploy two cotd version (cats / cities)


#Blue green deployment



oc expose svc/cities --name=bluegreen-route -n cotd-dev

oc patch route/bluegreen-route -p '{"spec":{"to":{"name":"cats"}}}' -n cotd-dev


#expose route


oc expose svc/pets --name=cats
oc expose svc/cities --name=cities

#set traffic split

oc set route-backends cities cities=1 pets=1

#see traffic

for i in {1..10}; do curl -s http://$(oc get route cities  --template='{{ .spec.host }}')/item.php | grep "data/images" | awk '{print $5}'; done;