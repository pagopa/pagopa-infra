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
        <base />
        <validate-jwt header-name="IdentityToken"
                      failed-validation-httpcode="401"
                      failed-validation-error-message="IdentityToken is missing, expired, or invalid."
                      require-expiration-time="true"
                      require-signed-tokens="true"
                      output-token-variable-name="sourceToken">
            <openid-config url="${openid-config-url}" />
            <issuer-signing-keys>
                <key certificate-id="${cert_id}" />
            </issuer-signing-keys>
            <audiences>
                <audience>api.platform.pagopa.it</audience>
            </audiences>
            <issuers>
                <issuer>${selfcare-issuer}</issuer>
                <issuer>${pagopa-issuer}</issuer>
            </issuers>
        </validate-jwt>
        <set-variable name="tokenData" value='@{
            Jwt sourceToken = (Jwt)context.Variables["sourceToken"];
            string desiredRole = context.Request.Url.Query.GetValueOrDefault("desidered_role", "").Trim();

            try
            {
                string orgId = "";
                string orgVat = "";
                JArray roles = null;
                string organizationClaim = sourceToken.Claims.GetValueOrDefault("organization", "");

                if (!string.IsNullOrWhiteSpace(organizationClaim))
                {
                    JObject organization = JObject.Parse(organizationClaim);
                    orgId = organization.Value&lt;string>("id") ?? "";
                    orgVat = organization.Value&lt;string>("fiscal_code") ?? "";

                    JToken rolesToken = organization["roles"];
                    if (rolesToken is JArray)
                    {
                        roles = (JArray)rolesToken;
                    }
                    else if (rolesToken != null &amp;&amp; rolesToken.Type == JTokenType.String)
                    {
                        JToken parsedRoles = JToken.Parse(rolesToken.ToString());
                        roles = parsedRoles is JArray
                            ? (JArray)parsedRoles
                            : new JArray(parsedRoles);
                    }
                }
                else
                {
                    orgId = sourceToken.Claims.GetValueOrDefault("org_id", "");
                    orgVat = sourceToken.Claims.GetValueOrDefault("org_vat", "");

                    string[] roleClaims;
                    if (sourceToken.Claims.TryGetValue("roles", out roleClaims) &amp;&amp; roleClaims != null &amp;&amp; roleClaims.Length &gt; 0)
                    {
                        roles = new JArray();
                        foreach (string roleClaim in roleClaims)
                        {
                            JToken parsedRoleClaim = JToken.Parse(roleClaim);
                            if (parsedRoleClaim is JArray)
                            {
                                foreach (JToken role in (JArray)parsedRoleClaim)
                                {
                                    roles.Add(role.DeepClone());
                                }
                            }
                            else
                            {
                                roles.Add(parsedRoleClaim);
                            }
                        }
                    }
                }

                if (roles == null || roles.Count == 0)
                {
                    return new JObject(
                        new JProperty("state", "invalid_roles")
                    ).ToString(Formatting.None);
                }

                foreach (JToken roleToken in roles)
                {
                    JObject roleObject = roleToken as JObject;
                    if (roleObject == null
                        || string.IsNullOrWhiteSpace(roleObject.Value&lt;string>("partyRole"))
                        || string.IsNullOrWhiteSpace(roleObject.Value&lt;string>("role")))
                    {
                        return new JObject(
                            new JProperty("state", "invalid_roles")
                        ).ToString(Formatting.None);
                    }
                }

                JObject selectedRole = (JObject)roles.First();
                if (!string.IsNullOrWhiteSpace(desiredRole))
                {
                    selectedRole = roles
                        .OfType&lt;JObject>()
                        .FirstOrDefault(role => string.Equals(
                            role.Value&lt;string>("role"),
                            desiredRole,
                            StringComparison.Ordinal
                        ));

                    if (selectedRole == null)
                    {
                        return new JObject(
                            new JProperty("state", "role_not_assigned")
                        ).ToString(Formatting.None);
                    }
                }

                return new JObject(
                    new JProperty("state", "ok"),
                    new JProperty("org_id", orgId),
                    new JProperty("org_vat", orgVat),
                    new JProperty("org_party_role", selectedRole.Value&lt;string>("partyRole")),
                    new JProperty("org_role", selectedRole.Value&lt;string>("role")),
                    new JProperty("roles", roles.DeepClone())
                ).ToString(Formatting.None);
            }
            catch (Exception)
            {
                return new JObject(
                    new JProperty("state", "invalid_roles")
                ).ToString(Formatting.None);
            }
        }' />
        <choose>
            <when condition='@(JObject.Parse((string)context.Variables["tokenData"]).Value&lt;string>("state") == "invalid_roles")'>
                <return-response>
                    <set-status code="400" reason="Bad Request" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>text/plain</value>
                    </set-header>
                    <set-body>IdentityToken has a missing or invalid roles structure.</set-body>
                </return-response>
            </when>
            <when condition='@(JObject.Parse((string)context.Variables["tokenData"]).Value&lt;string>("state") == "role_not_assigned")'>
                <return-response>
                    <set-status code="403" reason="Forbidden" />
                    <set-header name="Content-Type" exists-action="override">
                        <value>text/plain</value>
                    </set-header>
                    <set-body>The requested role is not assigned to the user.</set-body>
                </return-response>
            </when>
        </choose>
        <set-variable name="pagopaPortalToken" value='@{
            JObject tokenData = JObject.Parse((string)context.Variables["tokenData"]);
            string encodedHeader = Convert.ToBase64String(
                Encoding.UTF8.GetBytes(
                    new JObject(
                        new JProperty("typ", "JWT"),
                        new JProperty("alg", "RS256")
                    ).ToString(Formatting.None)
                )
            ).Replace("=", "").Replace("+", "-").Replace("/", "_");

            long iat = DateTimeOffset.UtcNow.ToUnixTimeSeconds();
            long exp = DateTimeOffset.UtcNow.AddHours(8).ToUnixTimeSeconds();
            Jwt sourceToken = (Jwt)context.Variables["sourceToken"];

            JObject payload = new JObject(
                new JProperty("iat", iat),
                new JProperty("exp", exp),
                new JProperty("aud", "api.platform.pagopa.it"),
                new JProperty("iss", "${pagopa-issuer}"),
                new JProperty("uid", sourceToken.Claims.GetValueOrDefault("uid", "")),
                new JProperty("name", sourceToken.Claims.GetValueOrDefault("name", "")),
                new JProperty("family_name", sourceToken.Claims.GetValueOrDefault("family_name", "")),
                new JProperty("email", sourceToken.Claims.GetValueOrDefault("email", "")),
                new JProperty("org_id", tokenData.Value&lt;string>("org_id")),
                new JProperty("org_vat", tokenData.Value&lt;string>("org_vat")),
                new JProperty("org_party_role", tokenData.Value&lt;string>("org_party_role")),
                new JProperty("org_role", tokenData.Value&lt;string>("org_role")),
                new JProperty("roles", tokenData["roles"].DeepClone())
            );

            string encodedPayload = Convert.ToBase64String(
                Encoding.UTF8.GetBytes(payload.ToString(Formatting.None))
            ).Replace("=", "").Replace("+", "-").Replace("/", "_");
            string message = encodedHeader + "." + encodedPayload;

            var signingCertificate = context.Deployment.Certificates
                .Where(certificate => certificate.Value.SubjectName.Name == "CN=${cert_cn}")
                .Select(certificate => certificate.Value)
                .FirstOrDefault();

            if (signingCertificate == null)
            {
                throw new Exception("Token exchange signing certificate is not available.");
            }

            using (RSA rsa = signingCertificate.GetRSAPrivateKey())
            {
                if (rsa == null)
                {
                    throw new Exception("Token exchange signing private key is not available.");
                }

                byte[] signature = rsa.SignData(
                    Encoding.UTF8.GetBytes(message),
                    HashAlgorithmName.SHA256,
                    RSASignaturePadding.Pkcs1
                );

                return message + "." + Convert.ToBase64String(signature)
                    .Replace("=", "")
                    .Replace("+", "-")
                    .Replace("/", "_");
            }
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
        <return-response>
            <set-status code="500" reason="Internal Server Error" />
            <set-header name="Content-Type" exists-action="override">
                <value>text/plain</value>
            </set-header>
            <set-body>Unable to generate the token.</set-body>
        </return-response>
    </on-error>
</policies>
