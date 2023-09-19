<policies>
  <inbound>
    <base />
    <choose>
      <when condition="@(((string)(context.Request.Method)).Contains("POST"))">
        <return-response>
          <set-status code="201" reason="CREATED" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body template="liquid">
            {
               "iupd":"ACA_77777777777_88888888888888887",
               "type":"F",
               "fiscalCode":"77777777777",
               "fullName":"Full name",
               "streetName":"Street name",
               "civicNumber":"civic number",
               "postalCode":"postal code",
               "city":"city",
               "province":"pr",
               "region":"region",
               "country":"IT",
               "email":"test@test.it",
               "phone":"phone number",
               "switchToExpired":false,
               "companyName":"company name",
               "officeName":"office name",
               "validityDate":"2099-12-31T23:59:59.999999",
               "paymentOption":[
                  {
                     "iuv":"88888888888888887",
                     "amount":500,
                     "description":"payment option description",
                     "isPartialPayment":false,
                     "dueDate":"2099-12-31T23:59:59.999999",
                     "retentionDate":"2099-12-31T23:59:59.999999",
                     "fee":100,
                     "transfer":[
                        {
                           "idTransfer":"1",
                           "amount":500,
                           "organizationFiscalCode":"77777777777",
                           "remittanceInformation":"remittanceInformations",
                           "category":"category",
                           "iban":"IT99C1234567890123456789012",
                           "postalIban":"IT99C0760167890123456789012",
                           "stamp":{
                              "hashDocument":"hashDocument",
                              "stampType":"st",
                              "provincialResidence":"RM"
                           }
                        }
                     ]
                  }
               ]
            }
          </set-body>
        </return-response>
      </when>
      <when condition="@(((string)(context.Request.Method)).Contains("GET"))">
        <return-response>
          <set-status code="404" reason="NOT FOUND" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body template="liquid">
            {
                "title": "Not found the debt position",
                "status": 404,
                "detail": "Not found a debt position for Organization Fiscal Code 77777777777 and IUPD 000000000000000009"
            }
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
