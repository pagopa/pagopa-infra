<policies>
    <inbound>
        <cors>
            <allowed-origins>
                <origin>https://${origin}</origin>
            </allowed-origins>
            <allowed-methods>
                <method>POST</method>
                <method>OPTIONS</method>
            </allowed-methods>
            <allowed-headers>
                <header>*</header>
            </allowed-headers>
        </cors>
        <validate-jwt header-name="IdentityToken" failed-validation-httpcode="401" require-expiration-time="true" require-signed-tokens="true" output-token-variable-name="outputToken">
            <openid-config url="${openid-config-url}" />
            <audiences>
                <audience>api.platform.pagopa.it</audience>
            </audiences>
            <issuers>
                <issuer>${selfcare-issuer}</issuer>
            </issuers>
        </validate-jwt>
        <set-variable name="pagopaPortalToken" value='@{
                    Jwt selcToken = (Jwt)context.Variables["outputToken"];
                    string organizationClaim = selcToken.Claims.GetValueOrDefault("organization", "");

                    if (string.IsNullOrWhiteSpace(organizationClaim))
                    {
                        throw new Exception("pagopaPortalToken: organization claim cannot be empty");
                    }

                    JObject organization = JObject.Parse(organizationClaim);
                    var org_id = organization.Value<string>("id");
                    var org_vat = organization.Value<string>("fiscal_code");
                    JArray roles = organization.Value<JArray>("roles");

                    if (roles == null || roles.Count == 0)
                    {
                        throw new Exception("pagopaPortalToken: organization.roles cannot be empty");
                    }

                    
                    string desiredRole = context.Request.Url.Query.GetValueOrDefault("desidered_role", "").Trim();
                    JObject selectedRole = string.IsNullOrWhiteSpace(desiredRole)
                        ? roles.OfType<JObject>().FirstOrDefault()
                        : roles.OfType<JObject>().FirstOrDefault(role => role.Value<string>("role") == desiredRole);

                    if (selectedRole == null)
                    {
                        throw new Exception("pagopaPortalToken: requested role was not found");
                    }

                    var org_party_role = selectedRole.Value<string>("partyRole");
                    var org_role = selectedRole.Value<string>("role");

                    if (string.IsNullOrWhiteSpace(org_party_role) || string.IsNullOrWhiteSpace(org_role))
                    {
                        throw new Exception("pagopaPortalToken: selected role partyRole or role cannot be empty");
                    }

                    var JOSEProtectedHeader = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(
                        new {
                            typ = "JWT",
                            alg = "RS256"
                        }))).Replace("=", "").Replace("+", "-").Replace("/", "_");

                    var iat = DateTimeOffset.Now.ToUnixTimeSeconds();
                    var exp = new DateTimeOffset(DateTime.Now.AddHours(8)).ToUnixTimeSeconds();
                    var aud = "api.platform.pagopa.it";
                    var iss = "${pagopa-issuer}";
                    var uid = selcToken.Claims.GetValueOrDefault("uid", "");
                    var name = selcToken.Claims.GetValueOrDefault("name", "");
                    var family_name = selcToken.Claims.GetValueOrDefault("family_name", "");
                    var email = selcToken.Claims.GetValueOrDefault("email", "");
                    var payload = Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(
                    new {
                    iat,
                    exp,
                    aud,
                    iss,
                    uid,
                    name,
                    family_name,
                    email,
                    org_id,
                    org_vat,
                    org_party_role,
                    org_role,
                    roles
                    }
                    ))).Replace("=", "").Replace("+", "-").Replace("/", "_");

                    var message = $"{JOSEProtectedHeader}.{payload}";

                    using (RSA rsa = context.Deployment.Certificates.First(
                        c => c.Value.SubjectName.Name == "CN=${cert_cn}"
                    ).Value.GetRSAPrivateKey())
                    {
                        var signature = rsa.SignData(Encoding.UTF8.GetBytes(message), HashAlgorithmName.SHA256, RSASignaturePadding.Pkcs1);
                        return message + "." + Convert.ToBase64String(signature).Replace("=", "").Replace("+", "-").Replace("/", "_");
                    }

                    return message;
                }' />
        <return-response>
            <set-status code="200" reason="OK" />
            <set-header name="Content-Type" exists-action="override">
                <value>text/plain</value>
            </set-header>
            <set-body>@((string)context.Variables["pagopaPortalToken"])</set-body>
        </return-response>
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <trace source="pagopa_backoffice_token" severity="error">
            <message>pagoPA Backoffice Selfcare SSO Error</message>
            <metadata name="errorSource" value="@(context.LastError.Source)" />
            <metadata name="errorMessage" value="@(context.LastError.Message)" />
            <metadata name="errorReason" value="@(context.LastError?.Reason ?? "-")" />
            <metadata name="errorSection" value="@(context.LastError?.Section ?? "-")" />
            <metadata name="errorPath" value="@(context.LastError?.Path ?? "-")" />
            <metadata name="errorStatusCode" value="@((context.Response?.StatusCode ?? -1).ToString())" />
        </trace>
        <base />
        <return-response>
            <set-status code="401" reason="Unauthorized" />
            <set-header name="Content-Type" exists-action="override">
                <value>text/plain</value>
            </set-header>
            <set-body>Unauthorized</set-body>
        </return-response>
    </on-error>
</policies>
