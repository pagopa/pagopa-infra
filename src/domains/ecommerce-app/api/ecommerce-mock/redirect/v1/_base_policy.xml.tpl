<policies>
  <inbound>
    <base />
      <choose>
        <when condition="@(((string)(context.Request.Url.Path)).Contains("redirections/refunds"))">
          <return-response>
            <set-status code="200" reason="OK" />
            <set-header name="Content-Type" exists-action="override">
              <value>application/json</value>
            </set-header>
            <set-body>@{
              string idTransaction = context.Request.Body.As<JObject>()["idTransaction"].ToString();
              return new JObject(
                      new JProperty("idTransaction", idTransaction),
                      new JProperty("outcome", "OK")
                  ).ToString();
              }
            </set-body>
          </return-response>
        </when>
        <when condition="@(((string)(context.Request.Url.Path)).Contains("redirections"))">
          <return-response>
            <set-status code="200" reason="OK" />
            <set-header name="Content-Type" exists-action="override">
              <value>application/json</value>
            </set-header>
            <set-body>@{
              string idTransaction = context.Request.Body.As<JObject>()["idTransaction"].ToString();
              return new JObject(
                      new JProperty("url", "http://redirect.url.io/"),
                      new JProperty("idTransaction", idTransaction),
                      new JProperty("idPSPTransaction", "123"),
                      new JProperty("amount", 10000),
                      new JProperty("timeout", 600000)
                  ).ToString();
              }
            </set-body>
          </return-response>
        </when>
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