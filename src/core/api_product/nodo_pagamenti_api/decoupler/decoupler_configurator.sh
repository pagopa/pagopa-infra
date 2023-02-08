#!/usr/bin/env bash

env=$1
file="decoupler_configuration_$env.json"
destination="decoupler-configuration-${env:0:1}.xml"

new_conf=$(cat $file | jq '@json' | sed "s;https://;https:\\\\\\\\\\\\\\\\\\/\\\\\\\\\\\\\\\\\\/;g" | sed "s;http://;http:\\\\\\\\\\\\\\\\\\/\\\\\\\\\\\\\\\\\\/;g" )
echo "<fragment>
    <set-variable name=\"configuration\" value=\"@{return $new_conf;}\" />
</fragment>" > $destination
