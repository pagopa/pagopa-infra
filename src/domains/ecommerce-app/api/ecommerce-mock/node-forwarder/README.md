# eCommerce Redirect mock (PSP called through Node forwarder)

Api management mock for Redirect transactions apis (that are made through Node Forwarder)

### Mocked api responses and input trigger

| api path              | mocked response     | trigger input                                               | 
|-----------------------|---------------------|-------------------------------------------------------------|
| /redirections         | OK                  | any                                                         |
| /redirections/refunds | 200 OK - outcome KO | request.transactionId == "00000000000000000000000000000001" |
| /redirections/refunds | KO (404)            | request.transactionId == "00000000000000000000000000000002" |
| /redirections/refunds | KO (500)            | request.transactionId == "00000000000000000000000000000003" |
| /redirections/refunds | 200 OK - outcome OK | any other transaction id value                              |

