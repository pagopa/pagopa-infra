<policies>
    <inbound>
      <base />
      <!-- Check idPayment in IO env- START -->
      <set-header name="x-functions-key" exists-action="override">
        <value>{{pagopa-fn-checkout-key}}</value>
      </set-header>
      <set-backend-service base-url="{{pagopa-fn-checkout-url}}/api/v1" />
      <!-- Check idPayment in IO env - END -->
    </inbound>
    <outbound>
    <choose>
        <when condition="@(context.Response.StatusCode != 200)">
          <!-- Check idPayment in pagoPA env- START -->
          <set-variable name="codice_contesto_pagamento" value="@(context.Request.MatchedParameters["codice_contesto_pagamento"])" />
          <set-variable name="pagopa_appservice_proxy_url" value="{{pagopa-appservice-proxy-url}}" />
          <send-request ignore-error="true" timeout="10" response-variable-name="response" mode="new">
            <set-url>@($"{(string)context.Variables["pagopa_appservice_proxy_url"]}/payment-activations/{(string)context.Variables["codice_contesto_pagamento"]}")</set-url>
            <set-method>GET</set-method>
          </send-request>
          <choose>
            <when condition="@(((IResponse)context.Variables["response"]).StatusCode == 200)">
              <return-response>
                <set-status code="200" />
                <set-body>
                   @{
                    return new JObject(
                           new JProperty("idPagamento",
                            ((IResponse)context.Variables["response"]).Body.As<JObject>()["idPagamento"]
                            )
                           ).ToString();
                     }
                  </set-body>
              </return-response>
            </when>
          </choose>
          <!-- Check idPayment in pagoPA env- End -->
        </when>
      </choose>
      <base />
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
