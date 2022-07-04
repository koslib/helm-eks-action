#!/bin/sh

set -e

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

echo "::set-output name=response::$response"
