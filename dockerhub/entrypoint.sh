#!/bin/sh

set -e

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG="${PWD}/kubeconfig"
chmod 600 ${PWD}/kubeconfig

if [[ -n "${INPUT_PLUGINS// /}" ]]
then
    plugins=$(echo $INPUT_PLUGINS | tr ",")

    for plugin in $plugins
    do
        echo "installing helm plugin: [$plugin]"
        helm plugin install $plugin
    done
fi

echo "running entrypoint command(s)"

response=$(sh -c " $INPUT_COMMAND")

echo "command response: $response"

# write multi-line response to github output
echo "response<<EOF" >> $GITHUB_OUTPUT
echo "$response" >> $GITHUB_OUTPUT
echo "EOF" >> $GITHUB_OUTPUT
