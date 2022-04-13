<policies>
    <inbound>
      <base />
      <rate-limit-by-key calls="50" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
      <choose>
          <when condition="@( context.Request.Url.Path.Contains("payment-requests") || context.Request.Url.Path.Contains("payment-activations") && context.Operation.Method.Equals("POST") )">
            <return-response>
              <set-status code="200" />
              <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
              </set-header>
              <set-body>@{
                  return new JObject(
                          new JProperty("importoSingoloVersamento", 1200),
                          new JProperty("codiceContestoPagamento", "f3cf08a09e1b11ec877559d3b4798277"),
                          new JProperty("causaleVersamento", "pagamentoTest"),
                          new JProperty("enteBeneficiario", new JObject(
                            new JProperty("identificativoUnivocoBeneficiario", "77777777777"),
                            new JProperty("denominazioneBeneficiario", "companyName"),
                            new JProperty("denomUnitOperBeneficiario", "officeName")
                          )
                        )
                      ).ToString();
             }</set-body>
            </return-response>
          </when>
          <when condition="@( context.Request.Url.Path.Contains("payment-activations") && context.Operation.Method.Equals("GET") )">
            <send-request ignore-error="true" timeout="10" response-variable-name="response" mode="new">
                <set-url>https://portal.test.pagopa.gov.it/pmmockserviceapiauth/nodo/sit/send/rpt</set-url>
                <set-method>PATCH</set-method>
                <set-header name="Content-Type" exists-action="override">
                  <value>application/json</value>
                </set-header>
                <set-header name="ocp-apim-subscription-key" exists-action="override">
                  <value>{{pagopa-mock-services-api-key}}</value>
                </set-header>
                <set-body>@{
                  return new JObject(
                          new JProperty("identificativoIntermediarioPA", "90000000001"),
                          new JProperty("identificativoStazioneIntermediarioPA", "90000000001_01"),
                          new JProperty("identificativoDominio", "90000000001"),
                          new JProperty("importoTotaleDaVersare", "12.00"),
                          new JProperty("responseEnum", "OK")
                      ).ToString();
             }</set-body>
            </send-request>
            <choose>
              <when condition="@(((IResponse)context.Variables["response"]).StatusCode == 200)">
              <set-variable name="responseAsString" value="@("{\"responseWithIdpayment\":" + (string)((IResponse)context.Variables["response"]).Body.As<string>() + "}")" />
              <set-variable name="idPayment" value="@{JObject json = JObject.Parse((string)context.Variables["responseAsString"]);
                  return (string)json["responseWithIdpayment"][0]["idPayment"];
              }" />
              <return-response>
                  <set-status code="200" />
                  <set-body>
                    @{
                      return new JObject(
                            new JProperty("idPagamento", context.Variables["idPayment"])
                            ).ToString();
                      }
                    </set-body>
                </return-response>
              </when>
            </choose>
          </when>
          <otherwise>
            <return-response>
              <set-status code="@(context.Response.StatusCode)" />
              <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
              </set-header>
              <set-body>@(((JObject) context.Variables["body"]).ToString())</set-body>
            </return-response>
          </otherwise>
        </choose>
    </inbound>
    <outbound>
        <set-header name="cache-control" exists-action="override">
            <value>no-store</value>
        </set-header>
        <base />
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
