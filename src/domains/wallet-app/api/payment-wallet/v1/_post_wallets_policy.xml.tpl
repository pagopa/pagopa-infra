<policies>
    <inbound>
      <set-variable  name="walletToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
      <!-- Get User IO START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="user-auth-body" mode="new">
          <set-url>@($"{{io-host}}/users?userId={(string)context.Variables["userId"]}")</set-url>
          <set-method>GET</set-method>
      </send-request>
      <choose>
        <when condition="@(((IResponse)context.Variables["user-auth-body"]).StatusCode != 200)">
          <return-response>
            <set-status code="502" reason="Bad Gateway" />
          </return-response>
        </when>
      </choose>
      <set-variable name="userAuth" value="@(((IResponse)context.Variables["user-auth-body"]).Body.As<JObject>())" />
      <!-- Get User IO END-->
      <!-- Post Token PDV START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="pdv-token" mode="new">
        <set-url>@($"{{pdv_api_base_path}}/tokens")</set-url>
        <set-body>@{
          JObject requestBody = (JObject)context.Variables["user-auth-body"];
          string fiscalCode = (string)operation["fiscalCode"];
          return new JObject(
                  new JProperty("fiscalCode", context.Variables["userAuth"])
              ).ToString();}
        </set-body>
        <set-method>POST</set-method>
      </send-request>
      <choose>
        <when condition="@(((IResponse)context.Variables["pdv-token"]).StatusCode != 200)">
          <return-response>
            <set-status code="502" reason="Bad Gateway" />
          </return-response>
        </when>
      </choose>
      <set-variable name="token" value="@(((IResponse)context.Variables["pdv-token"]).Body.As<JObject>())" />
      <!-- Post Token PDV END-->
      <!-- Token JWT START-->
      <!-- Token JWT END-->
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
