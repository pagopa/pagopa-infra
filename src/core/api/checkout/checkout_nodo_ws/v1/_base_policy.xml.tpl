<policies>
<inbound>
        <base />
        <ip-filter action="forbid">
          <!-- pagopa-p-appgateway-snet  -->
          <address-range from="10.1.128.0" to="10.1.128.255" />
        </ip-filter> 
        <set-variable name="ccp" value="@(context.Request.Body.As<XElement>(preserveContent: true).Descendants().FirstOrDefault(a => a.Name.LocalName == "codiceContestoPagamento")?.Value)" />
        <set-variable name="id_pagamento" value="@(context.Request.Body.As<XElement>(preserveContent: true).Descendants().FirstOrDefault(a => a.Name.LocalName == "idPagamento")?.Value)" />
        <set-backend-service base-url="{{pagopa-appservice-proxy-url}}/FespCdService" />
    </inbound>
    <outbound>
        <set-variable name="ecommerce_url" value="${ecommerce_url}"/>
        <send-request response-variable-name="transaction-check-result" ignore-error="true" mode="new">
            <set-url>@(String.Format("https://{0}/transactions/payment-context-codes/{1}/activation-results", (string)context.Variables["ecommerce_url"], (string)context.Variables["ccp"]))</set-url>
            <set-method>POST</set-method>
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-body>@{
                  return new JObject(
                          new JProperty("paymentToken", context.Variables["id_pagamento"])
                      ).ToString();
             }</set-body>
        </send-request>
        <choose>
            <when condition="@( ((((IResponse)context.Variables["transaction-check-result"]).StatusCode == 200) || ( ((IResponse)context.Variables["transaction-check-result"]).StatusCode == 404))  && (context.Response.StatusCode == 200))">
                <return-response>
                    <set-status code="200" />
                    <set-body template="liquid">
						<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd" xmlns:ppt="http://ws.pagamenti.telematici.gov/" xmlns:tns="http://PuntoAccessoCD.spcoop.gov.it">
							<soap:Body>
								<ppt:cdInfoWispResponse>
									<esito>OK</esito>
								</ppt:cdInfoWispResponse>
							</soap:Body>
						</soap:Envelope>
					</set-body>
                </return-response>
            </when>
            <otherwise>
                <return-response>
                    <set-status code="502" />
                    <set-body template="liquid">
						<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd" xmlns:ppt="http://ws.pagamenti.telematici.gov/" xmlns:tns="http://PuntoAccessoCD.spcoop.gov.it">
							<soap:Body>
								<ppt:cdInfoWispResponse>
									<esito>KO</esito>
									<fault>KO</fault>
								</ppt:cdInfoWispResponse>
							</soap:Body>
						</soap:Envelope>
					</set-body>
                </return-response>
            </otherwise>
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
