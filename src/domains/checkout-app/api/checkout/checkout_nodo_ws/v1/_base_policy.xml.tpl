<policies>
    <inbound>
      <base />
      <ip-filter action="forbid">
        <!-- pagopa-p-appgateway-snet  -->
        <address-range from="10.1.128.0" to="10.1.128.255" />
      </ip-filter>
      <set-variable name="ccp" value="@(context.Request.Body.As<XElement>(preserveContent: true).Descendants().FirstOrDefault(a => a.Name.LocalName == "codiceContestoPagamento")?.Value)" />
      <set-variable name="id_pagamento" value="@(context.Request.Body.As<XElement>(preserveContent: true).Descendants().FirstOrDefault(a => a.Name.LocalName == "idPagamento")?.Value)" />
      <!--<set-variable name="ecommerce_url" value="${ecommerce_ingress_hostname}"/-->
      <set-backend-service base-url="{{pagopa-appservice-proxy-url}}/FespCdService" />
    </inbound>
    <outbound>
      <!-- START ecommerce activation result  
      <choose>
        <when condition="@(context.Variables.GetValueOrDefault<string>("ecommerce_url","").Contains("pagopa.it"))">
          <send-request response-variable-name="transaction-check-result" ignore-error="true" mode="new">
            <set-url> @($"https://{(string)context.Variables["ecommerce_url"]}/pagopa-ecommerce-transactions-service/transactions/payment-context-codes/{(string)context.Variables["ccp"]}/activation-results")</set-url>
            <set-method>POST</set-method>
            <set-header name="Content-Type" exists-action="override">
              <value>application/json</value>
            </set-header>
            <set-body>@{
              return new JObject(
                      new JProperty("paymentToken", context.Variables["id_pagamento"])
                  ).ToString();}
            </set-body>
          </send-request>
        </when>
      </choose>
     END ecommerce activation result  -->
      <base />
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
