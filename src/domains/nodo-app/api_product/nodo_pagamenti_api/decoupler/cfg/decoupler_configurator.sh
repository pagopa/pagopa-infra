#!/usr/bin/env bash

env=$1
file="./api_product/nodo_pagamenti_api/decoupler/cfg/$env/decoupler_configuration.json"
destination="./api_product/nodo_pagamenti_api/decoupler/cfg/$env/decoupler-configuration.xml"


new_conf=$(cat $file | jq '@json' | sed "s;https://;https:\\\\\\\\\\\\\\\\\\/\\\\\\\\\\\\\\\\\\/;g" | sed "s;http://;http:\\\\\\\\\\\\\\\\\\/\\\\\\\\\\\\\\\\\\/;g" )
echo "<fragment>
    <set-variable name=\"configuration\" value=\"@{return $new_conf;}\" />
</fragment>" > $destination
