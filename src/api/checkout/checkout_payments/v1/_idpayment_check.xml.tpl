<policies>
    <inbound>
      <base />
      <!-- Check idPayment in IO env- START -->
      <set-header name="x-functions-key" exists-action="override">
        <value>{{pagopa-fn-checkout-key}}</value>
      </set-header>
      <set-backend-service base-url="{{pagopa-fn-checkout-url}}" />
      <!-- Check idPayment in IO env - END -->
    </inbound>
    <outbound>
      <base />
      <choose>
        <when condition="@(context.Response.StatusCode == 404)">
          <!-- Check idPayment in pagoPA env- START -->
          <set-variable name="codice_contesto_pagamento" value="@(context.Request.MatchedParameters["codice_contesto_pagamento"])" />
          <send-request ignore-error="true" timeout="10" response-variable-name="response" mode="new">
            <set-url>$"{{pagopa-appservice-proxy-url}}/api/v1/payment-activations/${context.Variables["codice_contesto_pagamento"]}"</set-url>
            <set-method>GET</set-method>
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
          </send-request>
          <!-- Check idPayment in pagoPA env- End -->
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
