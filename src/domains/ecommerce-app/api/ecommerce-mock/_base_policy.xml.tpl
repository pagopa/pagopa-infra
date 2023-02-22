<policies>
    <inbound>
      <base />

      <!-- verifyPaymentNotice -->
      <when condition="@(((string)context.Request.Headers.GetValueOrDefault("SOAPAction","")).Equals("verifyPaymentNotice")">
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
                          <paymentList></paymentList>
                          <paymentDescription></paymentDescription>
                          <fiscalCodePA></fiscalCodePA>
                          <companyName></companyName>
                          <officeName></officeName>
                      </soapenv:Body>
                  </soapenv:Envelope>
              </set-body>
          </return-response>
        </when>

      <!-- activatePaymentNotice -->
      <when condition="@(((string)context.Request.Headers.GetValueOrDefault("SOAPAction","")).Equals("activatePaymentNotice")">
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
                          <fiscalCodePA>PLACEHOLDER</fiscalCodePA>
                          <companyName>PLACEHOLDER</companyName>
                          <officeName>PLACEHOLDER</officeName> 
                          <paymentToken>PLACEHOLDER</paymentToken>
                          <transferList>PLACEHOLDER</transferList> 
                          <creditorReferenceId>PLACEHOLDER</creditorReferenceId>
                      </soapenv:Body>
                  </soapenv:Envelope>
              </set-body>
          </return-response>
        </when>

        <!-- auth -->

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
