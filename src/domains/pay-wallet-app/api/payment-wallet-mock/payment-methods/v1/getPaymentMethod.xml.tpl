<policies>
  <inbound>
    <base />

    <set-variable name="paymentMethodId" value="@(context.Request.MatchedParameters["id"])"/>
    <choose>
      <when condition="@(((string)context.Variables["paymentMethodId"]) == "f25399bf-c56f-4bd2-adc9-7aef87410609")">
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body template="liquid">
            {
              "id": "f25399bf-c56f-4bd2-adc9-7aef87410609",
              "name": "CARDS",
              "description": "Carta di credito o debito",
              "asset": "https://assets.cdn.platform.pagopa.it/creditcard/generic.png",
              "status": "ENABLED",
              "methodManagement": "ONBOARDABLE_ONLY",
              "paymentTypeCode": "CP",
              "ranges": [
                  {
                      "min": 0,
                      "max": 100000
                  }
              ],
              "brandAssets": {
                  "VISA": "https://assets.cdn.platform.pagopa.it/creditcard/visa.png",
                  "MC": "https://assets.cdn.platform.pagopa.it/creditcard/mastercard.png",
                  "DINERS": "https://assets.cdn.platform.pagopa.it/creditcard/diners.png",
                  "AMEX": "https://assets.cdn.platform.pagopa.it/creditcard/amex.png",
                  "MAESTRO": "https://assets.cdn.platform.pagopa.it/creditcard/maestro.png",
                  "MASTERCARD": "https://assets.cdn.platform.pagopa.it/creditcard/mastercard.png"
              }
          }
          </set-body>
        </return-response>
      </when>
      <otherwise>
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body template="liquid">
            {
              "id": "0d1450f4-b993-4f89-af5a-1770a45f5d71",
              "name": "PAYPAL",
              "description": "Pagamento veloce con PayPal",
              "asset": "https://assets.cdn.platform.pagopa.it/apm/paypal.png",
              "status": "ENABLED",
              "methodManagement": "ONBOARDABLE_ONLY",
              "paymentTypeCode": "PPAL",
              "ranges": [
                  {
                      "min": 0,
                      "max": 100000
                  }
              ]
            } 
          </set-body>
        </return-response>
      </otherwise>
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