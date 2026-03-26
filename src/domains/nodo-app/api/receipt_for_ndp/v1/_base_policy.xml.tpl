<!-- The policy defined in this file provides an example of using OAuth2 for authorization between the gateway and a backend. -->
<!-- It shows how to obtain an access token from Azure AD and forward it to the backend. -->

<!-- Send request to Azure AD to obtain a bearer token -->
<!-- Parameters: authorizationServer - format https://login.windows.net/TENANT-GUID/oauth2/token -->
<!-- Parameters: scope - a URI encoded scope value -->
<!-- Parameters: clientId - an id obtained during app registration -->
<!-- Parameters: clientSecret - a URL encoded secret, obtained during app registration -->

<policies>
    <inbound>
        <base />

        <set-variable name="transactionId" value="@(context.Request.MatchedParameters["transactionId"])" />
        <set-variable name="deviceId" value="@(context.Request.OriginalUrl.Query.GetValueOrDefault("deviceId"))" />
        <set-variable name="clientId" value="@(context.Request.OriginalUrl.Query.GetValueOrDefault("clientId"))" />
        <choose>
            <when condition="@(context.Variables["clientId"] == null || context.Variables["clientId"] == "")">
                <return-response>
                    <set-status code="403" reason="Forbidden missing clientId header" />
                </return-response>
            </when>
            <otherwise>
                <!-- if swclient oauth2-->
                <choose>
                    <when condition="@("swclient".Equals(context.Variables["clientId"]))">

                        <send-request ignore-error="true" timeout="20" response-variable-name="bearerToken" mode="new">
                            <set-url>${authorizationServer}</set-url>
                            <set-method>POST</set-method>
                            <set-header name="Content-Type" exists-action="override">
                                <value>application/x-www-form-urlencoded</value>
                            </set-header>
                            <set-body>
                        @{
                            return "client_id=${clientId}&client_secret=${clientSecret}&grant_type=client_credentials";
                        }
                            </set-body>
                        </send-request>

                        <set-header name="Authorization" exists-action="override">
                            <value>
                        @("Bearer " + (String)((IResponse)context.Variables["bearerToken"]).Body.As<JObject>()["access_token"])
                                </value>
                        </set-header>

                        <!-- endpoint1 + /mil-payment-notice/payments/{transactionId} -->
                        <set-backend-service base-url="https://${endpoint1}" />
                        <rewrite-uri template="@("/mil-payment-notice/payments/"+(string)context.Variables["transactionId"])" copy-unmatched-params="true" />
                    </when>
                    <otherwise>
                        <!-- if ecommerce -->
                        <!-- endpoint2 + /ecommerce/transaction-user-receipts-service/v1/transactions/{transactionId}/user-receipts -->

                        <!--
                        <set-backend-service base-url="https://${endpoint2}/ecommerce/transaction-user-receipts-service/v1" />
                        <set-header name="Ocp-Apim-Subscription-Key" exists-action="override">
                            <value>${subscriptionKey}</value>
                        </set-header>
                        -->
                        
                        <!-- https://github.com/MicrosoftDocs/azure-docs/issues/79088 -->
                        <set-header name="x-api-key" exists-action="override">
                            <value>{{ecommerce-transactions-service-api-key-value}}</value>
                        </set-header>
                        <set-backend-service base-url="https://weu${environ}.ecommerce.internal.${environ}.platform.pagopa.it/pagopa-ecommerce-transactions-service" />
                    </otherwise>                       
                </choose>
        
            </otherwise>            
        </choose>
        


        <!--  Don't expose APIM subscription key to the backend. -->
        <!-- <set-header exists-action="delete" name="Ocp-Apim-Subscription-Key"/> -->

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
