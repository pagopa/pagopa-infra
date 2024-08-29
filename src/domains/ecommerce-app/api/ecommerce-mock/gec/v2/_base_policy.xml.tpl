<policies>
  <inbound>
    <base />
      <set-variable name="calculateFeeRequest" value="@((JObject)context.Request.Body.As<JObject>(true))" />
      <set-variable name="calculateFeePaymentMethod" value="@((string)((JObject)context.Variables["calculateFeeRequest"])["paymentMethod"])" />
      <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
         
          <set-body template="liquid">
                {
                    "belowThreshold": false,
                    "bundleOptions": [
                        {
                            "taxPayerFee": 150,
                            "actualPayerFee": 150,
                            "paymentMethod": "{{context.Variables["calculateFeePaymentMethod"]}}",
                            "touchpoint": "CHECKOUT",
                            "idBundle": "fd399270-ef0b-40fe-badc-ba7905c852a8",
                            "bundleName": "PagaCPERRATO",
                            "bundleDescription": "Il servizio consente di pagare da AppIO e CheckOut pagoPa ai titolari di Postepay senza necessariamente inserire i dati della carta.",
                            "idsCiBundle": [],
                            "idPsp": "PPAYITR1XXX",
                            "idChannel": "06874351007_08",
                            "idBrokerPsp": "06874351007",
                            "onUs": false,
                            "abi": "36081",
                            "pspBusinessName": "PagaCPERRATO",
                            "fees": []
                        },
                        {
                            "taxPayerFee": 150,
                            "actualPayerFee": 150,
                            "paymentMethod": "{{context.Variables["calculateFeePaymentMethod"]}}",
                            "touchpoint": "CHECKOUT",
                            "idBundle": "f0c9a2b6-bbb4-4681-bcdf-692a538d9af1",
                            "bundleName": "Paga con Postepay",
                            "bundleDescription": "Il servizio Paga con Postepay consente di pagare i bollettini ai titolari di Postepay senza necessariamente inserire i dati della carta.",
                            "idsCiBundle": [],
                            "idPsp": "PPAYITR1XXX",
                            "idChannel": "06874351007_07",
                            "idBrokerPsp": "06874351007",
                            "onUs": false,
                            "abi": "36081",
                            "pspBusinessName": "Paga con Postepay",
                            "fees": []
                        },
                        {
                            "taxPayerFee": 150,
                            "actualPayerFee": 150,
                            "paymentMethod": "{{context.Variables["calculateFeePaymentMethod"]}}",
                            "touchpoint": "CHECKOUT",
                            "idBundle": "63794fc3-295d-4bd8-9f94-30f0831b58f9",
                            "bundleName": "Carta di credito",
                            "pspBusinessName": "Carta di credito",
                            "bundleDescription": "Il servizio consente ai titolari di Carte di Credito Visa e MasterCard pagamenti di bollettini.",
                            "idsCiBundle": [],
                            "idPsp": "BPPIITRRXXX",
                            "idChannel": "97103880585_07",
                            "idBrokerPsp": "97103880585",
                            "onUs": false,
                            "abi": "07601",
                            "pspBusinessName": "Paga con Postepay",
                            "fees": []
                        },
                        {
                            "taxPayerFee": 100,
                            "actualPayerFee": 100,
                            "paymentMethod": "{{context.Variables["calculateFeePaymentMethod"]}}",
                            "touchpoint": "CHECKOUT",
                            "idBundle": "7e9110cd-15c7-48a5-be4f-864684d78181",
                            "bundleName": "Pagamento con carta",
                            "pspBusinessName": "Pagamento con carta",
                            "bundleDescription": "Il Servizio consente di eseguire pagamenti a favore delle PA con carte Nexi sui circuiti Visa, VPAY, Mastercard e Maestro.",
                            "idCiBundle": [],
                            "idPsp": "CIPBITMM",
                            "idChannel": "13212880150_02",
                            "idBrokerPsp": "13212880150",
                            "onUs": false,
                            "abi": "32875",
                            "pspBusinessName": "Intesa",
                            "fees": []
                        },
                        {
                            "taxPayerFee": 95,
                            "actualPayerFee": 95,
                            "paymentMethod": "{{context.Variables["calculateFeePaymentMethod"]}}",
                            "touchpoint": "CHECKOUT",
                            "idBundle": "abfc6624-4526-4ae0-9e5c-c90ae63799ef",
                            "bundleName": "Pagamento con carte",
                            "pspBusinessName": "Pagamento con carte",
                            "bundleDescription": "Il Servizio consente di effettuare pagamenti con carte emesse a valere sui circuiti VISA, MASTERCARD,MAESTRO",
                            "idCiBundle": [],
                            "idPsp": "UNCRITMM",
                            "idChannel": "00348170101_01",
                            "idBrokerPsp": "00348170101",
                            "onUs": false,
                            "abi": "02008",
                            "pspBusinessName": "Unicredit",
                            "fees": []
                        },
                        {
                            "taxPayerFee": 130,
                            "actualPayerFee": 130,
                            "paymentMethod": "{{context.Variables["calculateFeePaymentMethod"]}}",
                            "touchpoint": "CHECKOUT",
                            "idBundle": "be76edc6-61d2-45c8-a1e8-a33f594501e2",
                            "bundleName": "Pagamento con carte",
                            "pspBusinessName": "Pagamento con carte",
                            "bundleDescription": "Il Servizio consente di effettuare pagamenti con carte emesse a valere sui circuiti VISA, MASTERCARD,MAESTRO",
                            "idCiBundle": [],
                            "idPsp": "UNCRITMM",
                            "idChannel": "00348170101_01",
                            "idBrokerPsp": "00348170101",
                            "onUs": false,
                            "abi": "02008",
                            "pspBusinessName": "Unicredit",
                            "fees": []
                        },
                        {
                            "taxPayerFee": 90,
                            "actualPayerFee": 90,
                            "paymentMethod": "{{context.Variables["calculateFeePaymentMethod"]}}",
                            "touchpoint": "CHECKOUT",
                            "idBundle": "55dce031-6a32-4990-970e-6effa0693f7c",
                            "bundleName": "Pagamento con carte",
                            "pspBusinessName": "Pagamento con carte",
                            "bundleDescription": "Pagamento con carte",
                            "idCiBundle": [],
                            "idPsp": "BNLIITRR",
                            "idChannel": "05963231005_01",
                            "idBrokerPsp": "05963231005",
                            "onUs": false,
                            "abi": "33111",
                            "pspBusinessName": "Unicredit",
                            "fees": []
                        },
                        {
                            "taxPayerFee": 100,
                            "actualPayerFee": 100,
                            "paymentMethod": "{{context.Variables["calculateFeePaymentMethod"]}}",
                            "touchpoint": "CHECKOUT",
                            "idBundle": "537a3bd6-2770-44a7-a737-d06e1e05cc8c",
                            "bundleName": "Pagamento con Carte",
                            "pspBusinessName": "Pagamento con carte",
                            "bundleDescription": "Clienti e non delle Banche del Gruppo Intesa Sanpaolo possono disporre pagamenti con carte di pagamento VISA-MASTERCARD",
                            "idCiBundle": [],
                            "idPsp": "BCITITMM",
                            "idChannel": "00799960158_10",
                            "idBrokerPsp": "00799960158",
                            "onUs": false,
                            "abi": "03069",
                            "pspBusinessName": "Intesa Sanpaolo",
                            "fees": []
                        },
                        {
                          "taxPayerFee": 150,
                          "actualPayerFee": 150,
                          "paymentMethod": "{{context.Variables["calculateFeePaymentMethod"]}}",
                          "touchpoint": "CHECKOUT",
                          "idBundle": "21813904-945b-4db0-b50b-10cf838111ae",
                          "bundleName": "PagaCPERRATO",
                          "bundleDescription": "Il servizio consente di pagare da AppIO e CheckOut pagoPa ai titolari di Postepay senza necessariamente inserire i dati della carta.",
                          "idsCiBundle": [],
                          "idPsp": "POSOIT22XXX",
                          "idChannel": "06874351007_08",
                          "idBrokerPsp": "06874351007",
                          "onUs": false,
                          "abi": "36081",
                          "pspBusinessName": "PagaCPERRATO",
                          "fees": []
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
