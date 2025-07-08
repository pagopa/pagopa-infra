<policies>
  <inbound>
    <set-variable name="requestBody" value="@((JObject)context.Request.Body.As<JObject>(true))" />
    <set-variable name="transactionId" value="@(((JObject)context.Variables["requestBody"]).Value<string>("transactionId") ?? "-")"/>
    <choose>
        <when condition="@(((string)(context.Variables["transactionId"])).Equals("00000000000000000000000000000001"))">
            <!-- Bad request error response with generic description -->
            <return-response>
                    <set-status code="400" reason="Bad Request" />
                    <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                    </set-header>
                    <set-body>
                        {
                            "outcome": "KO",
                            "description": "400 Bad request error"
                        }
                    </set-body>
                </return-response>
        </when>
        <when condition="@(((string)(context.Variables["transactionId"])).Equals("00000000000000000000000000000002"))">
            <!-- not found error response with generic description -->
            <return-response>
                    <set-status code="404" reason="Not found" />
                    <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                    </set-header>
                    <set-body>
                        {
                            "outcome": "KO",
                            "description": "404 Not found error"
                        }
                    </set-body>
                </return-response>
        </when>
        <when condition="@(((string)(context.Variables["transactionId"])).Equals("00000000000000000000000000000003"))">
            <!-- 422 unprocessable entity error response with generic description -->
            <return-response>
                    <set-status code="422" reason="Unprocessable entity" />
                    <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                    </set-header>
                    <set-body>
                        {
                            "outcome": "KO",
                            "description": "422 Unprocessable entity"
                        }
                    </set-body>
                </return-response>
        </when>
        <when condition="@(((string)(context.Variables["transactionId"])).Equals("00000000000000000000000000000004"))">
             <!-- 422 unprocessable enity error response with Node did not receive RPT yet description" -->
             <return-response>
                    <set-status code="422" reason="Unprocessable entity" />
                    <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                    </set-header>
                    <set-body>
                        {
                            "outcome": "KO",
                            "description": "Node did not receive RPT yet"
                        }
                    </set-body>
                </return-response>
        </when>
        <when condition="@(((string)(context.Variables["transactionId"])).Equals("00000000000000000000000000000005"))">
            <!-- 500 internal server error response-->
            <return-response>
                    <set-status code="500" reason="Internal server error" />
                    <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                    </set-header>
                    <set-body>
                        {
                            "outcome": "KO",
                            "description": "Internal server error"
                        }
                    </set-body>
                </return-response>
        </when>
        <when condition="@(((string)(context.Variables["transactionId"])).Equals("00000000000000000000000000000006"))">
            <!-- simulate a long processing response (20 sec) -->
            <retry condition="@(true)" count="2" interval="10" />
            <return-response>
                    <set-status code="500" reason="Internal server error" />
                    <set-header name="Content-Type" exists-action="override">
                    <value>application/json</value>
                    </set-header>
                    <set-body>
                        {
                            "outcome": "KO",
                            "description": "Internal server error"
                        }
                    </set-body>
                </return-response>
        </when>
        <otherwise>
            <return-response>
                <set-status code="200" reason="OK" />
                <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
                </set-header>
                <set-body>
                    {
                        "outcome": "OK"
                    }
                </set-body>
            </return-response>
        </otherwise>
    </choose>
    
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