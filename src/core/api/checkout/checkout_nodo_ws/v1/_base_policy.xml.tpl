<policies>
    <inbound>
      <base />
      <ip-filter action="forbid">
        <!-- pagopa-p-appgateway-snet  -->
        <address-range from="10.1.128.0" to="10.1.128.255" />
      </ip-filter>  
      <set-backend-service base-url="{{pagopa-appservice-proxy-url}}/FespCdService" />
    </inbound>
    <outbound>
      <base />
        
      <set-variable name="ecommerce_url" value="${ecommerce_url}" />
      <set-variable name="ccp" value="@((string)context.Request.Body.As<JObject>(preserveContent: true)["soapenv$Envelope"]["soapenv$Body"]["cdInfoWisp"]["codiceContestoPagamento"])" />

      <!-- pagopa-proxy returned error -->
      <send-request response-variable-name="transaction-check-result" ignore-error="true" timeout="10" mode="new">
        <set-url>@(String.Format("https://{0}/pagopa-ecommerce-transactions-service/transactions/payment-context-codes/{1}/activation-results", (string)context.Variables["ecommerce_url"], (string)context.Variables["ccp"] ))</set-url>
        <set-method>POST</set-method>
        <set-header name="Content-Type" exists-action="override">
          <value>application/x-www-form-urlencoded</value>
        </set-header>
      </send-request>
      
      <choose>
        <when condition="@( (((IResponse)context.Variables["transaction-check-result"]).StatusCode == 200) && (context.Response.StatusCode == 200))">
        <return-response>
              <set-status code="200" />
              <set-body>
                <soapenv:Envelope xmlns:tns="" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
                  <soapenv:Body>
                    <esito>OK</esito>
                  </soapenv:Body>
                </soapenv:Envelope>
              </set-body>
          </return-response>
        </when>

        <otherwise>
          <return-response>
              <set-status code="502" />
              <set-body>
                <soapenv:Envelope xmlns:tns="" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
                  <soapenv:Body>
                    <fault>KO</fault>
                    <esito>KO</esito>
                  </soapenv:Body>
                </soapenv:Envelope>
              </set-body>
          </return-response>
        </otherwise>
      </choose>
    </outbound>

    <backend>
      <base />
    </backend>
    
    <on-error>
      <base />
    </on-error>
  
  </policies>
