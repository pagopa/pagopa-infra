<policies>
  <inbound>
    <base />

    <set-variable name="requestBody" value="@( (JObject) context.Request.Body.As<JObject>(preserveContent: true) )" />
    <set-variable name="sessionId" value="@( (string) ((JObject) context.Variables["requestBody"])["sessionId"] )" />

    <cache-lookup-value variable-name="paymentMethod" key="@( (string) context.Variables["sessionId"] )" />
    <choose>
      <when condition="@( ((string) context.Variables["paymentMethod"]) == "CARDS")">
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body>
            @{
              var response = "{\n" +
                    "  \"state\": \"GDI_VERIFICATION\",\n" +
                    "  \"fieldSet\": {\n" +
                    "    \"sessionId\": \"052211e8-54c8-4e0a-8402-e10bcb8ff264\",\n" +
                    "    \"fields\": [\n" +
                    "      {\n" +
                    "        \"type\": \"GDI\",\n" +
                    "        \"class\": \"GDI\",\n" +
                    "        \"id\": \"GDI\",\n" +
                    "        \"src\": \"https:/example.com/iframe.html\"\n" +
                    "      }\n" +
                    "    ]\n" +
                    "  }\n" +
                    "}";
              
              return response;
            }
          </set-body>
        </return-response>
      </when>
      <otherwise>
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body>
          @{
            var response =
            "{\n" +
            "  \"sessionId\": \"" + context.Variables["sessionId"] + "\",\n" +
            "  \"securityToken\": \"SECURITY_TOKEN\",\n" +
            "  \"state\": \"REDIRECT_TO_EXTERNAL_DOMAIN\",\n" +
            "  \"url\": \"https://example.com\"\n" +
            "}\n";

            return response;
          }
          </set-body>
        </return-response>
      </otherwise>
    </choose>
  </inbound>
  <outbound>
    <base />
  </outbound>
  <backend>
    <base />
  </backend>
  <on-error>
    <base />
  </on-error>
</policies>