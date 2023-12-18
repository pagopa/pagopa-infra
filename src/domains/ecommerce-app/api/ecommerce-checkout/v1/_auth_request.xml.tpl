<policies>
    <inbound>
        <base />
        <set-header name="x-pgs-id" exists-action="delete" />
        <set-header name="x-transaction-id" exists-action="delete" />
        <set-variable name="requestTransactionId" value="@{
            return context.Request.MatchedParameters["transactionId"];
        }"/>
        <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" output-token-variable-name="jwtToken">
            <issuer-signing-keys>
                <key>{{ecommerce-checkout-transaction-jwt-signing-key}}</key>
            </issuer-signing-keys>
        </validate-jwt>
        <set-variable name="tokenTransactionId" value="@{
        var jwt = (Jwt)context.Variables["jwtToken"];
        if(jwt.Claims.ContainsKey("transactionId")){
           return jwt.Claims["transactionId"][0];
        }
        return "";
        }"/>
        <set-variable name="XPAYPspsList" value="${ecommerce_xpay_psps_list}"/>
        <set-variable name="VPOSPspsList" value="${ecommerce_vpos_psps_list}"/>
        <set-variable name="NPGPspsList" value="${ecommerce_npg_psps_list}"/>
        <set-variable name="pspId" value="@(((string)((JObject)context.Request.Body.As<JObject>(preserveContent: true))["pspId"]))"/>
        <set-variable name="pgsId" value="@{
            string[] xpayList = ((string)context.Variables["XPAYPspsList"]).Split(',');
            string[] vposList = ((string)context.Variables["VPOSPspsList"]).Split(',');
            string[] npgList = ((string)context.Variables["NPGPspsList"]).Split(',');
            string pspId = (string)(context.Variables.GetValueOrDefault("pspId",""));
            if (xpayList.Contains(pspId)) {
                return "XPAY";
            }
            if (vposList.Contains(pspId)) {
                return "VPOS";
            }
            if (npgList.Contains(pspId)) {
                return "NPG";
            }
            return "";
        }"/>
        <choose>
            <when condition="@(((string)context.Request.Headers.GetValueOrDefault("Origin","")).Equals("https://dev.checkout.pagopa.it"))">
                <set-variable name="pgsId" value="NPG" />
            </when>
        </choose>
        <choose>
            <when condition="@((string)context.Variables.GetValueOrDefault("tokenTransactionId","") != (string)context.Variables.GetValueOrDefault("requestTransactionId",""))">
                <return-response>
                    <set-status code="401" reason="Unauthorized"/>
                </return-response>
            </when>
            <when condition="@((string)context.Variables["pgsId"] != "")">
                <set-header name="x-pgs-id" exists-action="override">
                    <value>@((string)context.Variables.GetValueOrDefault("pgsId",""))</value>
                </set-header>
            </when>
            <otherwise>
                <return-response>
                    <set-status code="400"/>
                    <set-header name="Content-Type" exists-action="override">
                        <value>application/json</value>
                    </set-header>
                    <set-body>@{
                  return new JObject(
                    new JProperty("title", "Bad request - invalid idPsp"),
                    new JProperty("status", 400),
                    new JProperty("detail", "Invalid PSP - gateway matching")
                  ).ToString();
                }</set-body>
                </return-response>
            </otherwise>
        </choose>
        <choose>
          <when condition="@((string)context.Variables.GetValueOrDefault("requestTransactionId","") != "")">
            <set-header name="x-transaction-id" exists-action="override">
                <value>@((string)context.Variables.GetValueOrDefault("requestTransactionId",""))</value>
            </set-header>
          </when>
        </choose>
    </inbound>
    <outbound>
        <base/>
    </outbound>
    <backend>
        <base/>
    </backend>
    <on-error>
        <base/>
    </on-error>
</policies>
