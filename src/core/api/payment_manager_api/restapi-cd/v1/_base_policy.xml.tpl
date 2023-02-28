<policies>
    <inbound>
      <base />
        <!-- Mock bancomat pans Start-->
        <set-variable name="cardNumer" value="@{
        Random rand = new Random();
        byte[] buf = new byte[8];
        rand.NextBytes(buf);
        long longRand = BitConverter.ToInt64(buf, 0);
        return (Math.Abs(longRand % (1000000000000000 - 9999999999999999)) + 1000000000000000);}" />
        <set-variable name="cardNumerMas" value="@( Convert.ToInt64(context.Variables["cardNumer"]).ToString().Substring(3,14) )" />
        <set-variable name="cardNumerHashCode" value="@( Convert.ToInt64(context.Variables["cardNumer"]).ToString().GetHashCode() )" />
        <choose>
          <when condition="@( context.Request.Url.Path.Contains("bancomat/pans") )">
              <return-response>
                  <set-header name="Content-Type" exists-action="override">
                      <value>application/json</value>
                  </set-header>
                  <set-body template="liquid">
          {
            "data": {
              "data": [
                {
                  "abi": "08934",
                  "cardNumber": "{{context.Variables["cardNumer"]}}",
                  "cardPartialNumber": "****{{context.Variables["cardNumerMas"]}}",
                  "expiringDate": "2030-12-01T08:50:15.927Z",
                  "hpan": "{{context.Variables["cardNumerHashCode"]}}",
                  "productType": "PP",
                  "tokens": null,
                  "validityState": "V"
                }
              ],
              "messages": [
                {
                  "caName": "MOCK",
                  "cardsNumber": 1,
                  "code": "0"
                }
              ],
              "requestId": "MOCK-"
            }
          }
          </set-body>
              </return-response>
          </when>
      </choose>
        <!-- Mock bancomat pans End-->
      <choose>
        <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Contains("prf.platform.pagopa.it"))">
          <set-variable name="backend-base-url" value="@($"{{pm-host-prf}}/pp-restapi-CD/v1")" />
        </when>
        <otherwise>
          <set-variable name="backend-base-url" value="@($"{{pm-host}}/pp-restapi-CD/v1")" />
        </otherwise>
      </choose>
      <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
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
