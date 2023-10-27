<policies>
    <inbound>
      <set-variable  name="walletToken"  value="@(context.Request.Headers.GetValueOrDefault("Authorization", "").Replace("Bearer ",""))"  />
      <choose>
        <when condition="@(((string)context.Variables["walletToken"]) == "")">
            <return-response>
                <set-status code="401" reason="Unauthorized" />
                <set-body>
                    @{
                    JObject errorResponse = new JObject();
                    errorResponse["title"] = "Unauthorized";
                    errorResponse["status"] = 401;
                    errorResponse["detail"] = "Unauthorized";
                    return errorResponse.ToString();
                    }
                </set-body>
          </return-response>
        </when>
      </choose>
      <!-- Session PM START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="pmSessionResponse" mode="new">
          <set-url>@($"{{pm-host}}/pp-restapi-CD/v1/users/actions/start-session?token={(string)context.Variables["walletToken"]}")</set-url>
          <set-method>GET</set-method>
      </send-request>
       <choose>
        <when condition="@(((IResponse)context.Variables["pmSessionResponse"]).StatusCode != 200)">
         <return-response>
                <set-status code="401" reason="Unauthorized" />
                <set-body>
                    @{
                    JObject errorResponse = new JObject();
                    errorResponse["title"] = "Unauthorized";
                    errorResponse["status"] = 401;
                    errorResponse["detail"] = "Unauthorized";
                    return errorResponse.ToString();
                    }
                </set-body>
          </return-response>
        </when>
      </choose>
      <set-variable name="pmSessionBody" value="@(((IResponse)context.Variables["pmSessionResponse"]).Body.As<JObject>())" />
      <set-variable name="sessionToken"  value="@(((JObject)context.Variables["pmSessionBody"])["data"]["sessionToken"].ToString())" />
       <choose>
        <when condition="@(((string)context.Variables["sessionToken"]) != "")">
         <return-response>
                <set-status code="200" reason="OK" />
                <set-body>
                    @{
                    JObject response = new JObject();
                    response["sessionToken"] = (string)context.Variables["sessionToken"];
                    return response.ToString();
                    }
                </set-body>
          </return-response>
        </when>
        <otherwise>
         <return-response>
                <set-status code="401" reason="Unauthorized" />
                <set-body>
                    @{
                    JObject errorResponse = new JObject();
                    errorResponse["title"] = "Unauthorized";
                    errorResponse["status"] = 401;
                    errorResponse["detail"] = "Unauthorized";
                    return errorResponse.ToString();
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