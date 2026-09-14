<!--
    - Policies are applied in the order they appear.
    - Position <base/> inside a section to inherit policies from the outer scope.
    - Comments within policies are not preserved.
-->
<!-- Add policies as children to the <inbound>, <outbound>, <backend>, and <on-error> elements -->
<policies>
    <inbound>
        <base />

        <!-- Extracting variables from request -->
<!--        <set-variable name="fiscal_code" value="@((string) context.Request.Headers.GetValueOrDefault("x-fiscal-code", "N/A"))" />-->
<!--        <set-variable name="event_id" value="@((string) context.Request.MatchedParameters["event-id"])" />-->

<!--        &lt;!&ndash; Generating cacheable key &ndash;&gt;-->
<!--        <set-variable name="cached_key" value="@{-->
<!--            try {-->
<!--                string eventId = (string) context.Request.MatchedParameters["event-id"];-->
<!--                if (eventId != null) {-->
<!--                    return "lap::" + eventId.Split(new[] { "_CART_" }, StringSplitOptions.None)[0];-->
<!--                }-->
<!--                return "lap::ERROR_DURING_EVENTID_EXTRACTION";-->
<!--            } catch (Exception e) {-->
<!--                return "lap::ERROR_DURING_EVENTID_EXTRACTION";-->
<!--            }-->
<!--        }" />-->

<!--        &lt;!&ndash; Execute a lookup on APIM cache, checking if guard check lock was inserted  &ndash;&gt;-->
<!--        <cache-lookup-value key="@((string) context.Variables["cached_key"])" variable-name="attachment_generation_lock" default-value="NONE" caching-type="internal" />-->
<!--        <choose>-->

<!--            &lt;!&ndash; If guard check lock was set, return a custom error message &ndash;&gt;-->
<!--            <when condition="@( !((string) context.Variables["attachment_generation_lock"]).Equals("NONE") )">-->
<!--                <return-response>-->
<!--                    <set-status code="404" reason="Not found" />-->
<!--                    <set-header name="Content-Type" exists-action="override">-->
<!--                        <value>application/json</value>-->
<!--                    </set-header>-->
<!--                    <set-body>@{-->
<!--                        string fiscalCode = (string) context.Variables["fiscal_code"];-->
<!--                        string eventId = (string) context.Variables["event_id"];-->

<!--                        JObject response = new JObject();-->
<!--                        response["title"] = "Attachment not found";-->
<!--                        response["status"] = 404;-->
<!--                        response["detail"] = "Attachment of " + fiscalCode + " for bizEvent with id " + eventId + " is still generating";-->
<!--                        response["code"] = "AT_404_002";-->
<!--                        return response.ToString();-->
<!--                    }</set-body>-->
<!--                </return-response>-->
<!--            </when>-->
<!--        </choose>-->
    </inbound>

    <backend>
        <base />
    </backend>

    <outbound>
        <base />
<!--        <choose>-->

<!--            &lt;!&ndash; Check if response require to store guard check lock &ndash;&gt;-->
<!--            <when condition="@(context.Response.StatusCode == 404)">-->

<!--                &lt;!&ndash; Extracting applicative error code from response &ndash;&gt;-->
<!--                <set-variable name="applicative_error_code" value="@{-->
<!--                    try {-->
<!--                        var response = context.Response.Body.As<JObject>(preserveContent: true);-->
<!--                        return response.ContainsKey("code") ? (string) response["code"] : "N/A";-->
<!--                    } catch (Exception e) {-->
<!--                        return "N/A";-->
<!--                    }-->
<!--                }" />-->

<!--                <choose>-->
<!--                    &lt;!&ndash; Store hashed key in internal cache (with TTL of 60s) if applicative code refers to re-generation &ndash;&gt;-->
<!--                    <when condition="@( ((string) context.Variables["applicative_error_code"]).Equals("AT_404_002") )">-->
<!--                        <cache-store-value key="@((string)context.Variables["cached_key"])" value="GENERATING_ATTACHMENT" duration="${guard-lock-duration}" caching-type="internal" />-->
<!--                    </when>-->
<!--                </choose>-->
<!--            </when>-->
<!--        </choose>-->
    </outbound>

    <on-error>
        <base />
    </on-error>
</policies>
