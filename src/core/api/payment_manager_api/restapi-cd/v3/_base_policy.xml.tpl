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
        <when condition="@( (context.Request.Url.Path.EndsWith("/webview/transactions/cc/verify") || context.Request.Url.Path.EndsWith("/webview/paypal/onboarding/psp")) && context.Request.Body != null ) ">
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
          <!-- Credit card onboarding -->
          <when condition="@( context.Request.Url.Path.EndsWith("/webview/transactions/cc/verify") && (string)context.Request.Headers.GetValueOrDefault("Referer","") == "${payment_wallet_origin}")">
              <set-variable name="walletId" value="@{
                string requestBody = ((string)context.Variables["requestBody"]);
                string[] walletParamArray = requestBody!=null && requestBody.Split('&').Length >= 1 ? requestBody.Split('&') : new string[0];
                string walletIdFound = Array.Find(walletParamArray, formIdValue => formIdValue.StartsWith("idWallet=", StringComparison.Ordinal));
                string[] walletIdSplit = String.IsNullOrEmpty(walletIdFound) ? new string[0] : walletIdFound.Split('=');
                string walletId = walletIdSplit.Length == 2 ? walletIdSplit[1] : "";
                string walletIdHex = (long.Parse(walletId)).ToString("X").PadLeft(16,'0');
                string walletIdToUuid = "00000000-0000-4000-"+walletIdHex.Substring(0,4)+"-"+walletIdHex.Substring(4);
                return walletIdToUuid;
                }" />
              <set-header name="Set-Cookie" exists-action="append">
                  <value>@($"walletId={(string)context.Variables.GetValueOrDefault<string>("walletId","")}; Path=/pp-restapi-CD")</value>
              </set-header>
              <set-header name="Set-Cookie" exists-action="append">
                  <value>@($"isWalletOnboarding=true; Path=/pp-restapi-CD")</value>
              </set-header>
          </when>
           <!-- Paypal onboarding -->
          <when condition="@( context.Request.Url.Path.EndsWith("/webview/paypal/onboarding/psp") && (string)context.Request.Headers.GetValueOrDefault("Referer","") == "${payment_wallet_origin}")">
               <set-variable name="sessionToken" value="@{
                  string requestBody = ((string)context.Variables["requestBody"]);
                  string sessionTokenParam = requestBody!=null && requestBody.Split('&').Length >= 2 ? requestBody.Split('&')[1] : "";
                  string sessionToken = sessionTokenParam != null && sessionTokenParam.Split('=').Length == 2 ? sessionTokenParam.Split('=')[1] : "";
                  return sessionToken;
               }" />
               <set-header name="Set-Cookie" exists-action="append">
                 <value>@($"sessionToken={(string)context.Variables.GetValueOrDefault<string>("sessionToken","")}; Path=/pp-restapi-CD; HttpOnly")</value>
               </set-header>
              <set-header name="Set-Cookie" exists-action="append">
                <value>@($"isPaypalOnboarding=true; Path=/pp-restapi-CD")</value>
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
           <set-variable name="isWalletOnboarding" value="@{
              var cookie = context.Request.Headers.GetValueOrDefault("Cookie","");
              var pattern = "isWalletOnboarding=([\\S]*);";
              var regex = new Regex(pattern, RegexOptions.IgnoreCase);
              Match match = regex.Match(cookie);
              if(match.Success && match.Groups.Count == 2)
              {
                  return match.Groups[1].Value;
              }

              return "";
           }" />
           <set-variable name="isPaypalOnboarding" value="@{
             var cookie = context.Request.Headers.GetValueOrDefault("Cookie","");
             var pattern = "isPaypalOnboarding=([\\S]*);";
             var regex = new Regex(pattern, RegexOptions.IgnoreCase);
             Match match = regex.Match(cookie);
             if(match.Success && match.Groups.Count == 2)
             {
                 return match.Groups[1].Value;
             }

             return "";
          }" />
          <set-variable name="isEcommerceTransaction" value="@{
              string cookieHeaderValue = context.Request.Headers.GetValueOrDefault("Cookie","");
              string cookieName="isEcommerceTransaction";
                int startIdx = cookieHeaderValue.IndexOf(cookieName);
                if(startIdx>=0){
                  int endIdx = cookieHeaderValue.IndexOf(';',startIdx);
                  endIdx = endIdx<0 ? cookieHeaderValue.Length : endIdx;
                  return cookieHeaderValue.Substring(startIdx, endIdx-startIdx).Split('=')[1];
                }
              return "false";
          }" />
          <set-variable name="ecommerceTransactionId" value="@{
              string cookieHeaderValue = context.Request.Headers.GetValueOrDefault("Cookie","");
              string cookieName="ecommerceTransactionId";
                int startIdx = cookieHeaderValue.IndexOf(cookieName);
                if(startIdx>=0){
                  int endIdx = cookieHeaderValue.IndexOf(';',startIdx);
                  endIdx = endIdx<0 ? cookieHeaderValue.Length : endIdx;
                  return cookieHeaderValue.Substring(startIdx, endIdx-startIdx).Split('=')[1];
                }
              return "";
          }" />

          <choose>
            <when condition="@( (string)context.Variables["isEcommerceTransaction"] == "true")">
              <set-header name="Set-Cookie" exists-action="override">
                <value>isEcommerceTransaction=; path=/pp-restapi-CD; expires=Thu, 01 Jan 1970 00:00:00 GMT</value>
                <value>ecommerceTransactionId=; path=/pp-restapi-CD; expires=Thu, 01 Jan 1970 00:00:00 GMT</value>
              </set-header>
              <set-header name="location" exists-action="override">
                <value>@{
                    string location = $"{(string)context.Response.Headers.GetValueOrDefault("location","")}&walletId={context.Variables.GetValueOrDefault<string>("walletIdLogout","")}";
                    string ecommerceTransactionId = (string)context.Variables["ecommerceTransactionId"];
                    string[] splittedOriginalLocation = location.Split('?');
                    string queryParameters = splittedOriginalLocation.Length == 2 ? splittedOriginalLocation[1]: "";
                    location=$"https://{context.Request.OriginalUrl.Host}/ecommerce/io/v1/transactions/{ecommerceTransactionId}/outcomes?{queryParameters}";
                    return location;
                  }</value>
              </set-header>
            </when>
            <when condition="@( (string)context.Variables["isWalletOnboarding"] == "true")">
              <set-header name="Set-Cookie" exists-action="override">
                <value>walletId=; path=/pp-restapi-CD; expires=Thu, 01 Jan 1970 00:00:00 GMT</value>
                <value>isWalletOnboarding=; path=/pp-restapi-CD; expires=Thu, 01 Jan 1970 00:00:00 GMT</value>
              </set-header>
              <set-header name="location" exists-action="override">
                <value>@{
                    string location = $"{(string)context.Response.Headers.GetValueOrDefault("location","")}&walletId={context.Variables.GetValueOrDefault<string>("walletIdLogout","")}";
                    string[] splittedOriginalLocation = location.Split('?');
                    string queryParameters = splittedOriginalLocation.Length == 2 ? splittedOriginalLocation[1]: "";
                    location=$"https://{context.Request.OriginalUrl.Host}/payment-wallet-outcomes/v1/wallets/outcomes?{queryParameters}";
                    return location;
                  }</value>
              </set-header>
            </when>
            <when condition="@( (string)context.Variables["isPaypalOnboarding"] == "true")">
              <set-header name="Set-Cookie" exists-action="override">
                <value>sessionToken=; path=/pp-restapi-CD; expires=Thu, 01 Jan 1970 00:00:00 GMT; HttpOnly</value>
                <value>isPaypalOnboarding=; path=/pp-restapi-CD; expires=Thu, 01 Jan 1970 00:00:00 GMT</value>
              </set-header>
               <!-- Extract outcome -->
              <set-variable name="outcome" value="@{
                 string location = $"{(string)context.Response.Headers.GetValueOrDefault("location","")}";
                 string[] splittedOriginalLocation = location.Split('?');
                 string queryParameters = splittedOriginalLocation.Length == 2 ? splittedOriginalLocation[1]: "";
                 var pattern = "outcome=([\\S]*)";
                 var regex = new Regex(pattern, RegexOptions.IgnoreCase);
                 Match match = regex.Match(queryParameters);
                 if(match.Success && match.Groups.Count == 2)
                 {
                    return match.Groups[1].Value;
                 }
                 return "";
              }" />

              <choose>
                <when condition="@((string)context.Variables["outcome"] == "0")">
                    <!-- Extract sessionToken -->
                    <set-variable name="sessionToken" value="@{
                       var cookie = context.Request.Headers.GetValueOrDefault("Cookie","");
                       var pattern = "sessionToken=([\\S]*)";
                       var regex = new Regex(pattern, RegexOptions.IgnoreCase);
                       Match match = regex.Match(cookie);
                       if(match.Success && match.Groups.Count == 2)
                       {
                           var sessionToken = (string)match.Groups[1].Value;
                           return sessionToken.Substring(0, sessionToken.Length -1);
                       }

                       return "";
                    }" />
                     <!-- Get wallets by sessionToken -->
                     <send-request ignore-error="true" timeout="10" response-variable-name="wallet-response" mode="new">
                        <set-url>{{pm-host}}/pp-restapi-CD/v3/wallet</set-url>
                        <set-method>GET</set-method>
                        <set-header name="Authorization" exists-action="override">
                             <value>@("Bearer " + (string)context.Variables["sessionToken"])</value>
                        </set-header>
                    </send-request>
                     <choose>
                      <when condition="@(((IResponse)context.Variables["wallet-response"]).StatusCode != 200)">
                        <set-header name="location" exists-action="override">
                          <value>@{
                            string location = $"{(string)context.Response.Headers.GetValueOrDefault("location","")}&walletId={context.Variables.GetValueOrDefault<string>("walletId","")}";
                            string[] splittedOriginalLocation = location.Split('?');
                            string queryParameters = splittedOriginalLocation.Length == 2 ? splittedOriginalLocation[1]: "";
                            location=$"https://{context.Request.OriginalUrl.Host}/payment-wallet-outcomes/v1/wallets/outcomes?{queryParameters}";
                            return location;
                          }</value>
                        </set-header>
                      </when>
                      <otherwise>
                        <set-variable name="walletResponseJson" value="@(((IResponse)context.Variables["wallet-response"]).Body.As<JObject>())" />
                        <!-- Retrieve walletId -->
                        <set-variable name="walletId" value="@{
                         JArray wallets = (JArray)(((JObject)context.Variables["walletResponseJson"])["data"]);
                         foreach (JObject wallet in wallets) {
                            if(((string)wallet["walletType"]).Equals("PayPal")) {
                              string walletIdHex = (long.Parse((string)wallet["idWallet"])).ToString("X").PadLeft(16,'0');
                              string walletIdToUuid = "00000000-0000-4000-"+walletIdHex.Substring(0,4)+"-"+walletIdHex.Substring(4);
                              return walletIdToUuid;
                           }
                         }
                         return "";
                        }" />

                        <set-header name="location" exists-action="override">
                          <value>@{
                              string location = $"{(string)context.Response.Headers.GetValueOrDefault("location","")}&walletId={context.Variables.GetValueOrDefault<string>("walletId","")}";
                              string[] splittedOriginalLocation = location.Split('?');
                              string queryParameters = splittedOriginalLocation.Length == 2 ? splittedOriginalLocation[1]: "";
                              location=$"https://{context.Request.OriginalUrl.Host}/payment-wallet-outcomes/v1/wallets/outcomes?{queryParameters}";
                              return location;
                            }</value>
                        </set-header>
                      </otherwise>
                    </choose>
                </when>
                <otherwise>
                  <set-header name="location" exists-action="override">
                  <value>@{
                      string location = $"{(string)context.Response.Headers.GetValueOrDefault("location","")}";
                      string[] splittedOriginalLocation = location.Split('?');
                      string queryParameters = splittedOriginalLocation.Length == 2 ? splittedOriginalLocation[1]: "";
                      location=$"https://{context.Request.OriginalUrl.Host}/payment-wallet-outcomes/v1/wallets/outcomes?{queryParameters}";
                      return location;
                    }</value>
                  </set-header>
                </otherwise>
              </choose>
            </when>
          </choose>
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
