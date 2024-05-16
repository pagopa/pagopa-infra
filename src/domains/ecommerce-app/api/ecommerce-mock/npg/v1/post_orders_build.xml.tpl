<policies>
  <inbound>
    <base />

    <set-variable name="requestBody" value="@( (JObject) context.Request.Body.As<JObject>(preserveContent: true) )" />
    <set-variable name="paymentMethod" value="@( (string) ((JObject) ((JObject) context.Variables["requestBody"])["paymentSession"])["paymentService"] )" />

    <set-variable name="sessionId" value="@( Guid.NewGuid().ToString("N") )" />

    <cache-store-value key="@( (string) context.Variables["sessionId"] )" value="@( (string) context.Variables["paymentMethod"] )" duration="600" />

    <choose>
      <when condition="@( ((string) context.Variables["paymentMethod"]) == "CARDS")">
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body>
          @{
            var response = 
            "{\n" +
            "  \"sessionId\": \"" + context.Variables["sessionId"] +"\",\n" +
            "  \"securityToken\": \"SECURITY_TOKEN\",\n" +
            "  \"fields\": [\n" +
            "    {\n" +
            "      \"type\": \"TEXT\",\n" +
            "      \"class\": \"CARD_FIELD\",\n" +
            "      \"id\": \"CARD_NUMBER\",\n" +
            "      \"src\": \"https://example.com\"\n" +
            "    },\n" +
            "    {\n" +
            "      \"type\": \"TEXT\",\n" +
            "      \"class\": \"CARD_FIELD\",\n" +
            "      \"id\": \"EXPIRATION_DATE\",\n" +
            "      \"src\": \"https://example.com\"\n" +
            "    },\n" +
            "    {\n" +
            "      \"type\": \"TEXT\",\n" +
            "      \"class\": \"CARD_FIELD\",\n" +
            "      \"id\": \"SECURITY_CODE\",\n" +
            "      \"src\": \"https://example.com\"\n" +
            "    },\n" +
            "    {\n" +
            "      \"type\": \"TEXT\",\n" +
            "      \"class\": \"CARD_FIELD\",\n" +
            "      \"id\": \"CARDHOLDER_NAME\",\n" +
            "      \"src\": \"https://example.com\"\n" +
            "    }\n" +
            "  ]\n" +
            "}\n";

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
            "  \"sessionId\": \"" + context.Variables["sessionId"] +"\",\n" +
            "  \"securityToken\": \"SECURITY_TOKEN\",\n" +
            "  \"state\": \"REDIRECTED_TO_EXTERNAL_DOMAIN\",\n" +
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