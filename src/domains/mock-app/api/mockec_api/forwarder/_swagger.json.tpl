{
  "swagger": "2.0",
  "info": {
    "title": "mockec-forwarder",
    "version": "1.0"
  },
  "host": "${host}",
  "basePath": "/mockforwarder",
  "schemes": [
    "https"
  ],
  "paths": {
    "/forward": {
      "post": {
        "description": "forward",
        "operationId": "forward",
        "summary": "forward",
        "produces": [
          "text/xml"
        ],
        "responses": {
          "200": {
            "description": "",
            "examples": {
              "text/xml": "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:paf=\"http://pagopa-api.pagopa.gov.it/pa/paForNode.xsd\"> <soapenv:Header/> <soapenv:Body> <paf:paVerifyPaymentNoticeRes> <outcome>OK</outcome> <paymentList> <paymentOptionDescription> <amount>10.00</amount> <options>EQ</options> <dueDate>2021-12-31</dueDate> <detailDescription>test</detailDescription> <allCCP>1</allCCP> </paymentOptionDescription> </paymentList> <paymentDescription>test</paymentDescription> <fiscalCodePA>77777777777</fiscalCodePA> <companyName>PagoPA</companyName> <officeName>office</officeName> </paf:paVerifyPaymentNoticeRes> </soapenv:Body> </soapenv:Envelope>"
            }
          }
        }
      }
    }
  },
  "tags": []
}
