{
  "openapi": "3.0.1",
  "info": {
    "title": "qi-smo-jira-tickets-api",
    "description": "Api for QI SMO JIRA TICKETS pagoPA",
    "version": "1.0"
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "paths": {
    "/info": {
      "post": {
        "summary": "infoQiSmoJira",
        "operationId": "infoQiSmoJira",
        "responses": {
          "200": {
            "description": ""
          }
        }
      }
    }
  }
}
