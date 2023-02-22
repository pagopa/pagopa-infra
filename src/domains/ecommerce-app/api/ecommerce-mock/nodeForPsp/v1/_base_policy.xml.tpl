<policies>
    <inbound>
      <base />
      <!-- verifyPaymentNotice -->
      <choose>
        <when condition="@(((string)context.Request.Headers.GetValueOrDefault("SOAPAction","")).Equals("verifyPaymentNotice"))">
          <return-response>
            <set-status code="200" reason="OK" />
            <set-header name="Content-Type" exists-action="override">
              <value>application/xml</value>
            </set-header>
            <set-body template="liquid">
              <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                xmlns:nfpsp="http://pagopa-api.pagopa.gov.it/node/nodeForPsp.xsd">
              <soapenv:Header />
              <soapenv:Body>
                <outcome>OK</outcome>
                <fiscalCodePA>77777777777</fiscalCodePA>
                <companyName>Test Company Name</companyName>
              </soapenv:Body>
              </soapenv:Envelope>
            </set-body>
          </return-response>
        </when>
      </choose>

      <!-- activatePaymentNotice -->
      <choose>
        <when condition="@(((string)context.Request.Headers.GetValueOrDefault("SOAPAction","")).Equals("activatePaymentNotice"))">
          <return-response>
                <set-status code="200" reason="OK" />
                <set-header name="Content-Type" exists-action="override">
                    <value>application/xml</value>
                </set-header>
                <set-body template="liquid">
                  <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                      xmlns:nfpsp="http://pagopa-api.pagopa.gov.it/node/nodeForPsp.xsd">
                      <soapenv:Header />
                      <soapenv:Body>
                          <outcome>OK</outcome>
                          <totalAmount>100</totalAmount>
                          <paymentDescription>Pagamento di test</paymentDescription>
                          <fiscalCodePA>77777777777</fiscalCodePA>
                          <paymentToken>1c9d21390f2e4f4a9cb7d7e004c7deee</paymentToken>
                      </soapenv:Body>
                  </soapenv:Envelope>
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
