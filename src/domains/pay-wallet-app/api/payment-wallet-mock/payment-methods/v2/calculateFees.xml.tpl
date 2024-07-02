<policies>
  <inbound>
    <base />
    <set-variable name="paymentMethodId" value="@(context.Request.MatchedParameters["id"])"/>
    <choose>
      <when condition="@(((string)context.Variables["paymentMethodId"]) == "0d1450f4-b993-4f89-af5a-1770a45f5d71")">
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body template="liquid">
            {
                "paymentMethodName": "PAYPAL",
                "paymentMethodDescription": "Pagamento veloce con PayPal",
                "paymentMethodStatus": "ENABLED",
                "belowThreshold": false,
                "bundles": [{
                    "abi": "03069",
                    "bundleDescription": "Clienti e non delle Banche del Gruppo Intesa Sanpaolo possono disporre pagamenti con carte di pagamento VISA-MASTERCARD",
                    "bundleName": "Intesa Sanpaolo S.p.A",
                    "idBrokerPsp": "00799960158",
                    "idBundle": "95e9f05d-8db5-4738-aa70-362e973f872a",
                    "idChannel": "00799960158_15",
                    "idPsp": "BCITITMM",
                    "onUs": false,
                    "paymentMethod": "PPAL",
                    "taxPayerFee": 50,
                    "touchpoint": "IO",
                    "pspBusinessName": "Intesa Sanpaolo S.p.A"
                }],
                "asset": "https://assets.cdn.platform.pagopa.it/apm/paypal.png"
            }
          </set-body>
        </return-response>
      </when>
      <otherwise>
        <return-response>
          <set-status code="400" reason="OK" />
          <set-body>Unsupported method id by payment method mock</set-body>
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