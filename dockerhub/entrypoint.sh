#!/bin/bash

set -e

echo "${KUBE_CONFIG_DATA}" | base64 -d > kubeconfig
export KUBECONFIG="${PWD}/kubeconfig"
chmod 600 "${PWD}/kubeconfig"

if [[ -n "${INPUT_PLUGINS// /}" ]]
then
    plugins="$(echo "${INPUT_PLUGINS}" | tr ",")"

    for plugin in ${plugins}
    do
        echo "installing helm plugin: [${plugin}]"
        helm plugin install "${plugin}"
    done
fi

echo "running entrypoint command(s)"

TEST_INPUT_COMMAND=$(cat <<EOF
helm repo add helm_bankly https://acesso-bankly.github.io/bankly-helm-chart
helm repo update

helm upgrade -f deployment/values.yaml -i core-scouter helm_bankly/bankly-product --namespace antifraud-transactional --output json 
--set containerImage=***.dkr.ecr.us-east-1.amazonaws.com/antifraud-core-scouter:1.11.35-alpha,
environment=staging,
region=us-east-1,
tagResources.context=Transactional,
tagResources.type=specific,
tagResources.cc=909,
tagResources.product=Limit

EOF
)

echo "running command test: [${TEST_INPUT_COMMAND}]"

response=$(bash -c "${TEST_INPUT_COMMAND}")

{
  echo "response<<EOF";
  echo "$response";
  echo "EOF";
} >> "${GITHUB_OUTPUT}"