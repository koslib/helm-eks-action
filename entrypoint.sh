#!/bin/sh -l

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

echo "(debug) listing helm plugins"
ls -all ~/.helm/plugins

result="$($1)"

status=$?
echo ::set-output name=result::$result
echo "$result"
if [[ $status -eq 0 ]]; then exit 0; else exit 1; fi