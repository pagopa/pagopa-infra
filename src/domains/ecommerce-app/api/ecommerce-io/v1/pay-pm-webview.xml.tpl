<policies>
  <inbound>

    <set-method>POST</set-method>
    <set-body>
        @{ 
            var queryParams = context.Request.Url.Query;

            return new FormUrlEncodedContent(queryParams!); 
        }
    </set-body>

    <base />
  </inbound>

  <outbound>
    <base />
  </outbound>

  <backend>
      <base />
  </backend>
</policies>
