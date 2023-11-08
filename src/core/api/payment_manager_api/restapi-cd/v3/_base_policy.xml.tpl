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
      <choose>
        <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Contains("prf.platform.pagopa.it"))">
          <set-variable name="backend-base-url" value="@($"{{pm-host-prf}}/pp-restapi-CD/v3")" />
        </when>
        <otherwise>
          <set-variable name="backend-base-url" value="@($"{{pm-host}}/pp-restapi-CD/v3")" />
        </otherwise>
      </choose>
      <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
      <!-- cookie for walletId for new wallet backward compatible -->
      <choose>
        <when condition="@( context.Request.Url.Path.EndsWith("/webview/transactions/cc/verify") && context.Request.Body != null ) ">
          <set-variable name="requestBody" value="@(context.Request.Body.As<string>(preserveContent: true))" />
        </when>
      </choose>
    </inbound>
    <outbound>
      <base />
      <choose>
        <when condition="@(((string)context.Response.Headers.GetValueOrDefault("location","")).Contains("{{pm-host}}"))">
          <set-variable name="locationIn" value=" @(Regex.Replace((string)context.Response.Headers.GetValueOrDefault("location",""), "{{pm-host}}", "https://{{wisp2-gov-it}}"))" />
          <set-header name="location" exists-action="override">
              <value>@(context.Variables.GetValueOrDefault<string>("locationIn"))</value>
          </set-header>
        </when>
      </choose>
      <!-- cookie for walletId for new wallet backward compatible -->
      <choose>
          <when condition="@( context.Request.Url.Path.EndsWith("/webview/transactions/cc/verify") )">
              <set-variable name="walletId" value="@{
                    string requestBody = ((string)context.Variables["requestBody"]);
                    string walletParam = requestBody!=null && requestBody.Split('&').Length >= 1 ? requestBody.Split('&')[0] : "";
                    string walletId = walletParam != null && walletParam.Split('=').Length == 2 ? walletParam.Split('=')[1] : "";
                    return walletId;
                }" />
              <set-header name="Set-Cookie" exists-action="append">
                  <value>@($"walletId={(string)context.Variables.GetValueOrDefault<string>("walletId","")}; Path=/pp-restapi-CD")</value>
              </set-header>
          </when>
      </choose>
      <choose>
        <when condition="@(context.Request.Url.Path.Contains("/logout") )">
          <set-variable name="walletIdLogout" value="@{
              var cookie = context.Request.Headers.GetValueOrDefault("Cookie","");
              var pattern = "walletId=([\\S]*);";

              var regex = new Regex(pattern, RegexOptions.IgnoreCase);
              Match match = regex.Match(cookie);
              if(match.Success && match.Groups.Count == 2)
              {
                  return match.Groups[1].Value;
              }

              return "";
          }" />
          <set-variable name="isEcommerceTransaction" value="@{
              string[] cookieHeaderValues = context.Request.Headers.GetValueOrDefault("Cookie","");
              string cookieName="isEcommerceTransaction";
              foreach(string cookie in cookieHeaderValues){
                int startIdx = cookie.IndexOf(cookieName);
                if(startIdx>=0){
                  int endIdx = cookie.IndexOf(';',startIdx);
                  endIdx = endIdx<0 ? cookie.Length : endIdx;
                  return cookie.Substring(startIdx, endIdx-startIdx).Split('=')[1];
                }
              }
              return "";
          }" />
          <set-variable name="ecommerceTransactionId" value="@{
              string[] cookieHeaderValues = context.Request.Headers.GetValueOrDefault("Cookie","");
              string cookieName="ecommerceTransactionId";
              foreach(string cookie in cookieHeaderValues){
                int startIdx = cookie.IndexOf(cookieName);
                if(startIdx>=0){
                  int endIdx = cookie.IndexOf(';',startIdx);
                  endIdx = endIdx<0 ? cookie.Length : endIdx;
                  return cookie.Substring(startIdx, endIdx-startIdx).Split('=')[1];
                }
              }
              return "";
          }" />
          <set-header name="Set-Cookie" exists-action="override">
            <value>walletId=; path=/pp-restapi-CD; expires=Thu, 01 Jan 1970 00:00:00 GMT</value>
            <value>isEcommerceTransaction=; path=/pp-restapi-CD; expires=Thu, 01 Jan 1970 00:00:00 GMT</value>
            <value>ecommerceTransactionId=; path=/pp-restapi-CD; expires=Thu, 01 Jan 1970 00:00:00 GMT"</value>
          </set-header>
          <set-header name="location" exists-action="override">
            <value>@{
                string location = $"{(string)context.Response.Headers.GetValueOrDefault("location","")}&walletId={context.Variables.GetValueOrDefault<string>("walletIdLogout","")}";
                string isEcommerceTransaction = (string)context.Variables["isEcommerceTransaction"];
                string ecommerceTransactionId = (string)context.Variables["ecommerceTransactionId"];
                if("true".Equals(isEcommerceTransaction)){
                  string[] splittedOriginalLocation = location.Split('?');
                  string queryParameters = splittedOriginalLocation.Length == 2 ? splittedOriginalLocation[1]: "";
                  location=$"https://{context.Request.OriginalUrl.Host}/ecommerce/io/v1/transactions/{ecommerceTransactionId}/outcomes?{queryParameters}";
                }
                return location;
              }</value>
          </set-header>
        </when>
      </choose>
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
