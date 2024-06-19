<policies>
    <inbound>
    <base />
    <choose>
      <when condition="@("true".Equals("{{enable-pm-ecommerce-io}}") || !"{{pay-wallet-family-friends-user-ids}}".Contains(((string)context.Variables["sessionTokenUserId"])) )"> 
        <include-fragment fragment-id="pm-chk-wallet-session" />
      </when>
    </choose>
    <set-backend-service base-url="https://${ecommerce_hostname}/pagopa-ecommerce-payment-methods-service"/>
    </inbound>
    <outbound>
      <base />
      <choose>
        <when condition="@("true".Equals("{{enable-pm-ecommerce-io}}"))">
          <set-body>@{
            JObject response = context.Response.Body.As<JObject>();

            if (context.Response.StatusCode != 200) {
              return response.ToString();
            }

            HashSet<string> pmEnabledMethods = new HashSet<string>();
            pmEnabledMethods.Add("CP");
            pmEnabledMethods.Add("BPAY");
            pmEnabledMethods.Add("PPAL");

            foreach (var method in ((JArray) response["paymentMethods"])) {
              string typeCode = (string) method["paymentTypeCode"];
              if (pmEnabledMethods.Contains(typeCode)) {
                method["status"] = "ENABLED";
                method["methodManagement"] = "ONBOARDING_ONLY";
              } else {
                method["status"] = "DISABLED";
              }
            }

            return response.ToString();
          }
          </set-body>
        </when>
      </choose>
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
