<!--
    - Policies are applied in the order they appear.
    - Position <base/> inside a section to inherit policies from the outer scope.
    - Comments within policies are not preserved.
-->
<!-- Add policies as children to the <inbound>, <outbound>, <backend>, and <on-error> elements -->
<policies>
    <!-- Throttle, authorize, validate, cache, or transform the requests -->
    <inbound>
        <base />
    </inbound>
    <!-- Control if and how the requests are forwarded to services  -->
    <backend>
        <base />
    </backend>
    <!-- Customize the responses -->
    <outbound>
        <set-variable name="body" value="@(context.Response.Body.As<JObject>())" />
        <choose>
            <when condition="@( (context.Response.StatusCode == 200) && ((JObject) context.Variables["body"]) != null )">
                <set-status code="@(context.Response.StatusCode)" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                </set-header>
                <set-body>@{
                    return new JObject(
                            new JProperty("name", ((JObject) context.Variables["body"])["name"]),
                            new JProperty("familyName", ((JObject) context.Variables["body"])["familyName"])
                            ).ToString();
                        }</set-body>
                <validate-content unspecified-content-type-action="prevent" max-size="1000" size-exceeded-action="detect" errors-variable-name="responseBodyValidation">
                    <content-type-map any-content-type-value="application/json" />
                    <content type="application/json" validate-as="json" action="prevent" allow-additional-properties="false" />
                </validate-content>
            </when>
        </choose>
        <base />
    </outbound>
    <!-- Handle exceptions and customize error responses  -->
    <on-error>
        <base />
    </on-error>
</policies>
