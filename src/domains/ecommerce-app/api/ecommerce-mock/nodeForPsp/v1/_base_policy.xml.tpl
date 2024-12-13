<policies>
  <inbound>
    <base />
    <!-- verifyPaymentNotice -->
    <retry condition="@(true)" count="1" interval="3" />
    <choose>
      <when condition="@(((string)context.Request.Headers.GetValueOrDefault("SOAPAction","")).Equals("verifyPaymentNotice"))">
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/xml</value>
          </set-header>
          <set-body template="liquid">
            <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
              xmlns:xs="http://www.w3.org/2001/XMLSchema"
              xmlns:common="http://pagopa-api.pagopa.gov.it/xsd/common-types/v1.0.0/"
              xmlns:nfp="http://pagopa-api.pagopa.gov.it/node/nodeForPsp.xsd">
              <soapenv:Body>
                <nfp:verifyPaymentNoticeRes>
                  <outcome>OK</outcome>
                  <paymentList>
                    <paymentOptionDescription>
                      <amount>120.00</amount>
                      <options>EQ</options>
                      <dueDate>2021-07-31</dueDate>
                      <paymentNote>pagamentoTest</paymentNote>
                    </paymentOptionDescription>
                  </paymentList>
                  <paymentDescription>Pagamento di Test</paymentDescription>
                  <fiscalCodePA>77777777777</fiscalCodePA>
                  <companyName>companyName</companyName>
                  <officeName>officeName</officeName>
                </nfp:verifyPaymentNoticeRes>
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
            <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
              xmlns:xs="http://www.w3.org/2001/XMLSchema"
              xmlns:common="http://pagopa-api.pagopa.gov.it/xsd/common-types/v1.0.0/"
              xmlns:nfp="http://pagopa-api.pagopa.gov.it/node/nodeForPsp.xsd">
              <soapenv:Body>
                <nfp:activatePaymentNoticeRes>
                  <outcome>OK</outcome>
                  <totalAmount>120.00</totalAmount>
                  <paymentDescription>TARI/TEFA 2021</paymentDescription>
                  <fiscalCodePA>77777777777</fiscalCodePA>
                  <companyName>company PA</companyName>
                  <officeName>office PA</officeName>
                  <paymentToken>3d82a804063f46ed99dfa9e4a235774d</paymentToken>
                  <transferList>
                    <transfer>
                      <idTransfer>1</idTransfer>
                      <transferAmount>100.00</transferAmount>
                      <fiscalCodePA>77777777777</fiscalCodePA>
                      <IBAN>IT30N0103076271000001823603</IBAN>
                      <remittanceInformation>TARI Comune EC_TE</remittanceInformation>
                    </transfer>
                    <transfer>
                      <idTransfer>2</idTransfer>
                      <transferAmount>20.00</transferAmount>
                      <fiscalCodePA>01199250158</fiscalCodePA>
                      <IBAN>IT15V0306901783100000300001</IBAN>
                      <remittanceInformation>TEFA Comune Milano</remittanceInformation>
                    </transfer>
                  </transferList>
                  <creditorReferenceId>02031679174848001</creditorReferenceId>
                </nfp:activatePaymentNoticeRes>
              </soapenv:Body>
            </soapenv:Envelope>
          </set-body>
        </return-response>
      </when>
    </choose>
     <!-- activatePaymentNoticeV2 -->
    <choose>
      <when condition="@(((string)context.Request.Headers.GetValueOrDefault("SOAPAction","")).Equals("activatePaymentNoticeV2"))">
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/xml</value>
          </set-header>
          <set-body template="liquid">
            <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:common="http://pagopa-api.pagopa.gov.it/xsd/common-types/v1.0.0/" xmlns:nfp="http://pagopa-api.pagopa.gov.it/node/nodeForPsp.xsd">
                <soapenv:Body>
                    <nfp:activatePaymentNoticeV2Response>
                        <outcome>OK</outcome>
                        <totalAmount>10.00</totalAmount>
                        <paymentDescription>test</paymentDescription>
                        <fiscalCodePA>77777777777</fiscalCodePA>
                        <companyName>company</companyName>
                        <officeName>office</officeName>
                        <paymentToken>622918c5dd3142668826d3bdd9282589</paymentToken>
                        <transferList>
                            <transfer>
                                <idTransfer>1</idTransfer>
                                <transferAmount>10.00</transferAmount>
                                <fiscalCodePA>77777777777</fiscalCodePA>
                                <IBAN>IT45R0760103200000000001016</IBAN>
                                <remittanceInformation>/RFB/00202200000217527/5.00/TXT/</remittanceInformation>
                                <transferCategory>paGetPaymentTest</transferCategory>
                            </transfer>
                        </transferList>
                        <creditorReferenceId>11110100000009421</creditorReferenceId>
                    </nfp:activatePaymentNoticeV2Response>
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