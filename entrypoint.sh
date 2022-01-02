#!/bin/sh

set -e

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG="${PWD}/kubeconfig"

plugins=$(echo $INPUT_PLUGINS | tr ",")

for plugin in $plugins
do
    echo "installing helm plugin: [$plugin]"
    helm plugin install $plugin
done

echo "running entrypoint command(s)"

response=$(sh -c " $INPUT_COMMAND")

echo "::set-output name=response::$response"
