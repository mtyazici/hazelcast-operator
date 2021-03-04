#!/bin/bash

set -e
set -o pipefail

# Clean up after test
WORKDIR=$1
PROJECT=$2

oc delete -f --wait=true ${WORKDIR}/hazelcast.yaml 
oc delete -f --wait=true ${WORKDIR}/secret.yaml 
oc delete -f --wait=true ${WORKDIR}/hazelcast-rbac.yaml

oc delete --wait=true rolebinding hazelcast-enterprise-operator
oc delete --wait=true clusterrole hazelcast-enterprise-operator
oc delete --wait=true serviceaccount hazelcast-enterprise-operator
oc delete --wait=true deployment hazelcast-enterprise-operator

oc delete --wait=true secret pull-secret
oc delete project $PROJECT

oc logout