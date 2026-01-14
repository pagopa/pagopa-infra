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
        <set-variable name="fiscal_code" value="@((string) context.Request.Headers.GetValueOrDefault("x-fiscal-code", "N/A"))" />
        <set-variable name="event_id" value="@((string) context.Request.MatchedParameters["event-id"])" />

        <!-- Generating hashed key -->
        <set-variable name="hashed_key" value="@{

            try {
                string fiscalCode = (string) context.Variables["fiscal_code"];
                string eventId = (string) context.Variables["event_id"];
                string key = fiscalCode + ":" + eventId;

                var keyAsByteArray = Encoding.UTF8.GetBytes(key);
                var hashedKey = SHA256.Create().ComputeHash(keyAsByteArray);
                var builder = new System.Text.StringBuilder(hashedKey.Length * 2);
                foreach (var b in hashedKey) {
                    builder.Append(b.ToString("x2"));
                }
                return "lap::" + builder.ToString();
            } catch (Exception e) {
                return "lap::ERROR_DURING_KEY_HASHING";
            }
        }" />

        <!-- Execute a lookup on APIM cache, checking if guard check lock was inserted  -->
        <cache-lookup-value key="@((string) context.Variables["hashed_key"])" variable-name="attachment_generation_lock" default-value="NONE" caching-type="internal" />
        <choose>

            <!-- If guard check lock was set, return a custom error message -->
            <when condition="@( !((string) context.Variables["attachment_generation_lock"]).Equals("NONE") )">
                <return-response>
                    <set-status code="404" reason="Not found" />
                    <set-body>@{
                        string fiscalCode = (string) context.Variables["fiscal_code"];
                        string eventId = (string) context.Variables["event_id"];

                        JObject response = new JObject();
                        response["title"] = "Attachment not found";
                        response["status"] = 404;
                        response["detail"] = "Attachment of " + fiscalCode + " for bizEvent with id " + eventId + " is still generating";
                        response["code"] = "AT_404_002";
                        return response.ToString();
                    }</set-body>
                </return-response>
            </when>
        </choose>
    </inbound>

    <backend>
        <base />
    </backend>

    <outbound>
        <base />
        <choose>

            <!-- Check if response require to store guard check lock -->
            <when condition="@(context.Response.StatusCode == 404)">

                <!-- Extracting applicative error code from response -->
                <set-variable name="applicative_error_code" value="@{
                    try {
                        var response = context.Response.Body.As<JObject>(preserveContent: true);
                        return response.ContainsKey("code") ? (string) response["code"] : "N/A";
                    } catch (Exception e) {
                        return "N/A";
                    }
                }" />

                <choose>
                    <!-- Store hashed key in internal cache (with TTL of 60s) if applicative code refers to re-generation -->
                    <when condition="@( ((string) context.Variables["applicative_error_code"]).Equals("AT_404_002") )">
                        <cache-store-value key="@((string)context.Variables["hashed_key"])" value="GENERATING_ATTACHMENT" duration="${guard-lock-duration}" caching-type="internal" />
                    </when>
                </choose>
            </when>
        </choose>
    </outbound>

    <on-error>
        <base />
    </on-error>
</policies>
