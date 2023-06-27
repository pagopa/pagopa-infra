<policies>
  <inbound>
    <base />
      <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body template="liquid">
                {
                  "belowThreshold": true,
                  "bundleOptions": [
                    {
                      "abi": "abi1",
                      "bundleDescription": "bundleDescription1",
                      "bundleName": "bundleName1",
                      "idBrokerPsp": "idBrokerPsp1",
                      "idBundle": "idBundle1",
                      "idChannel": "idChannel1",
                      "idCiBundle": "idCiBundle1",
                      "idPsp": "idPsp1",
                      "onUs": true,
                      "paymentMethod": "CP",
                      "primaryCiIncurredFee": 0,
                      "taxPayerFee": 0,
                      "touchpoint": "touchpoint1"
                    },
                    {
                      "abi": "abi2",
                      "bundleDescription": "bundleDescription2",
                      "bundleName": "bundleName2",
                      "idBrokerPsp": "idBrokerPsp2",
                      "idBundle": "idBundle2",
                      "idChannel": "idChannel2",
                      "idCiBundle": "idCiBundle2",
                      "idPsp": "idPsp2",
                      "onUs": false,
                      "paymentMethod": "paymentMethod2",
                      "primaryCiIncurredFee": 0,
                      "taxPayerFee": 0,
                      "touchpoint": "touchpoint2"
                    }
                  ]
                }
          </set-body>
      </return-response>
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