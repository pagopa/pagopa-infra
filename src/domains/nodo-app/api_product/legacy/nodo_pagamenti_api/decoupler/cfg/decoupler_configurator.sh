#!/usr/bin/env bash

env=$1
file="./api_product/legacy/nodo_pagamenti_api/decoupler/cfg/$env/decoupler_configuration.json"
file_9_18="./api_product/legacy/nodo_pagamenti_api/decoupler/cfg/$env/decoupler_configuration_9_18.json"
file_18_9="./api_product/legacy/nodo_pagamenti_api/decoupler/cfg/$env/decoupler_configuration_18_9.json"
destination="./api_product/legacy/nodo_pagamenti_api/decoupler/cfg/$env/decoupler-configuration.xml"


new_conf=$(cat $file | jq '@json' | sed "s;https://;https:\\\\\\\\\\\\\\\\\\/\\\\\\\\\\\\\\\\\\/;g" | sed "s;http://;http:\\\\\\\\\\\\\\\\\\/\\\\\\\\\\\\\\\\\\/;g" )
new_conf_9_18=$(cat $file_9_18 | jq '@json' | sed "s;https://;https:\\\\\\\\\\\\\\\\\\/\\\\\\\\\\\\\\\\\\/;g" | sed "s;http://;http:\\\\\\\\\\\\\\\\\\/\\\\\\\\\\\\\\\\\\/;g" )
new_conf_18_9=$(cat $file_18_9 | jq '@json' | sed "s;https://;https:\\\\\\\\\\\\\\\\\\/\\\\\\\\\\\\\\\\\\/;g" | sed "s;http://;http:\\\\\\\\\\\\\\\\\\/\\\\\\\\\\\\\\\\\\/;g" )
echo "<fragment>
    <choose>
    <when condition="@(DateTime.UtcNow.TimeOfDay &lt; new TimeSpan(18, 0, 0)) and @(DateTime.UtcNow.TimeOfDay &gt;= new TimeSpan(9, 0, 0))">
            <set-variable name=\"configuration\" value=\"@{return $new_conf_9_18;}\" />
    </when>
    <when condition="@(DateTime.UtcNow.TimeOfDay >= new TimeSpan(18, 0, 0)) and @(DateTime.UtcNow.TimeOfDay &lt; new TimeSpan(9, 0, 0))">
        <set-variable name=\"configuration\" value=\"@{return $new_conf_18_9;}\" />
    </when>
    <otherwise>
        <set-variable name=\"configuration\" value=\"@{return $new_conf;}\" />
    </otherwise>
</choose>
</fragment>" > $destination
