# eCommerce NPG mock

Api management NPG api mock using hardcoded responses in policies.
This mock can be used in soak/integration tests to obtain a particular response based on some request input.

### Mocked api responses and input trigger

| api path                        | mocked response                   | trigger input                                 | 
|---------------------------------|-----------------------------------|-----------------------------------------------|
| POST /confirmPayment            | OK                                | any                                           |
| GET /cardData                   | OK                                | any                                           |
| GET /state                      | OK                                | any                                           |
| POST /orderBuild                | OK                                | any                                           |
| GET /orders/                    | OK - already refunded transaction | queryParam.orderId == "E00000000000000000"    |
| GET /orders/                    | KO - 404                          | queryParam.orderId == "E00000000000000001"    |
| GET /orders/                    | KO - 500                          | queryParam.orderId == "E00000000000000002"    |
| GET /orders/                    | OK - authorized                   | any other value                               |
| POST /{contractId}/deactivation | KO - 400 + PS0017                 | queryParam.contractId == "C00000000000000001" |
| POST /{contractId}/deactivation | KO - 500                          | queryParam.contractId == "C00000000000000002" |
| POST /{contractId}/deactivation | OK - Deactivated                  | any other value                               |
