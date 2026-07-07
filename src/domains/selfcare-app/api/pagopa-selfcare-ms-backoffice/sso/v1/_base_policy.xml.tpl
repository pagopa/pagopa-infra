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
                        return "";
                    }

                    JObject organization = JObject.Parse(organizationClaim);
                    var org_id = organization.Value&lt;string>("id");
                    var org_vat = organization.Value&lt;string>("fiscal_code");
                    JArray roles = organization.Value&lt;JArray>("roles");

                    if (roles == null || roles.Count == 0)
                    {
                        return "";
                    }

                    
                    string desiredRole = context.Request.Url.Query.GetValueOrDefault("desidered_role", "").Trim();
                    JObject selectedRole = string.IsNullOrWhiteSpace(desiredRole)
                        ? roles.OfType&lt;JObject>().FirstOrDefault()
                        : roles.OfType&lt;JObject>().FirstOrDefault(role => role.Value&lt;string>("role") == desiredRole);

                    if (selectedRole == null)
                    {
                        return "";
                    }

                    var org_party_role = selectedRole.Value&lt;string>("partyRole");
                    var org_role = selectedRole.Value&lt;string>("role");

                    if (string.IsNullOrWhiteSpace(org_party_role) || string.IsNullOrWhiteSpace(org_role))
                    {
                        return "";
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
        <choose>
            <when condition='@(string.IsNullOrEmpty((string)context.Variables["pagopaPortalToken"]))'>
                <return-response>
                    <set-status code="401" reason="Unauthorized" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>text/plain</value>
                    </set-header>
                    <set-body>The desired role is missing or is not assigned to the user.</set-body>
                </return-response>
            </when>
        </choose>
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
        <base />
    </on-error>
</policies>
