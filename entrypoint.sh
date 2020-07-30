#!/bin/sh -l

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

helm plugin install https://github.com/zendesk/helm-secrets
helm repo add stable https://kubernetes-charts.storage.googleapis.com/

result="$($1)"

status=$?
echo ::set-output name=result::$result
echo "$result"
if [[ $status -eq 0 ]]; then exit 0; else exit 1; fi
