# eCommerce Nodo per PM api mock

Api management Nodo per PM api mock using hardcoded responses in policies.
This mock can be used in soak/integration tests to obtain a particular response based on some request input.

### Mocked api responses and input trigger

| api path       | mocked response                                                                                                                                | trigger input                                               | 
|----------------|------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| /checkPosition | OK                                                                                                                                             | any                                                          |
| /closePayment  | KO (400) - description `Generic error description`                                                                                             | request.paymentToken[0] == "00000000000000000000000000000001"           |
| /closePayment  | KO (404) - description `Generic error description`                                                                                             | request.paymentToken[0] == "00000000000000000000000000000002" |
| /closePayment  | KO (422) - description `Generic error description`                                                                                             | request.paymentToken[0] == "00000000000000000000000000000003" |
| /closePayment  | KO (422) - description `Node did not receive RPT yet`                                                                                          | request.paymentToken[0] == "00000000000000000000000000000004" |
| /closePayment  | KO (500) - description `Generic error description`                                                                                             | request.paymentToken[0] == "00000000000000000000000000000005" |
| /closePayment  | KO (400) - description `Generic error description` after 20 sec timeout (can be used to test timeouts with client timeout lower than 20 sec)   | request.paymentToken[0] == "00000000000000000000000000000006" |
| /closePayment  | OK (200)                                                                                                                                       | any other payment token value                                   |
