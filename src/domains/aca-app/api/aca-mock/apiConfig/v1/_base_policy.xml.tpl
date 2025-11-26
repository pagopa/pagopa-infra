<policies>
  <inbound>
    <base />
    <choose>
      <when condition="@(((string)(context.Request.Method)).Contains("GET"))">
        <return-response>
          <set-status code="200" reason="OK" />
          <set-header name="Content-Type" exists-action="override">
            <value>application/json</value>
          </set-header>
          <set-body template="liquid">
            {
                "ibans_enhanced": [
                  {
                    "ci_owner": "77777777777",
                    "company_name": "Comune di Firenze",
                    "description": "Riscossione Tributi",
                    "iban": "IT99C0222211111000000000000",
                    "is_active": true,
                    "labels": [
                      {
                        "description": "The IBAN to use for CUP payments",
                        "name": "ACA"
                      }
                    ],
                    "publication_date": "2023-06-01T23:59:59.999Z",
                    "validity_date": "2023-04-01T13:49:19.897Z"
                  }
                ]
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
