<policies>
    <inbound>
    <base />
    <choose>
      <when condition="@("true".Equals("{{enable-pm-ecommerce-io}}"))"> 
        <include-fragment fragment-id="pm-chk-wallet-session" />
      </when>
    </choose>
    <set-backend-service base-url="https://${ecommerce_hostname}/pagopa-ecommerce-payment-methods-service"/>
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
