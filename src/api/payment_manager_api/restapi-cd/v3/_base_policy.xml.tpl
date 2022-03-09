<policies>
    <inbound>
      <cors>
        <allowed-origins>
          <origin>*</origin>
        </allowed-origins>
        <allowed-methods>
          <method>GET</method>
          <method>POST</method>
          <method>PUT</method>
          <method>DELETE</method>
          <method>OPTIONS</method>
        </allowed-methods>
        <allowed-headers>
          <header>*</header>
        </allowed-headers>
        </cors>
      <base />
      <set-backend-service base-url="{{pm-gtw-hostname}}/pp-restapi-CD/v3" />
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
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
