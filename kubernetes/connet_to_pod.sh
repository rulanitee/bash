#!/bin/bash
NS=$1
POD=$2
kubectl --namespace=$NS exec -ti $POD /bin/bash
