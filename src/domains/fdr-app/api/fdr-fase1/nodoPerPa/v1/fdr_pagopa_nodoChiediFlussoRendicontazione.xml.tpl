<policies>
    <inbound>
        <base />
        <set-variable name="enable_fdr_ci_soap_request_switch" value="{{enable-fdr-ci-soap-request-switch}}" />
        <set-variable name="is_fdr_nodo_pagopa_enable" value="@(${is-fdr-nodo-pagopa-enable})" />
        <choose>
            <when condition="@( context.Variables.GetValueOrDefault<bool>("is_fdr_nodo_pagopa_enable", false) &&
            context.Variables.GetValueOrDefault<string>("enable_fdr_ci_soap_request_switch", "").Equals("true") )">
                <!-- read body request to extract identificativoDominio -->
                <set-variable name="readrequest" value="@(context.Request.Body.As<string>(preserveContent: true))" />
                <set-variable name="identificativoDominio" value="@{
                      var dom2parse = ((string) context.Variables["readrequest"]);
                      String[] spearator = {"identificativoDominio"};
                      String[] result = dom2parse.Split(spearator, StringSplitOptions.RemoveEmptyEntries);
                      var identificativoDominio = result.Length > 2 ? result[1].Substring(1,result[1].Length-3).Replace("xmlns=\"\">", "") : "";
                return identificativoDominio;
                }" />
                <!-- get ftp-organization from named values -->
                <set-variable name="ftp_organization" value="{{ftp-organization}}" />
                <!-- is-ftp-enabled identifies if EC uses ftp, this traffic is managed by partner -->
                <set-variable name="is-ftp-enabled" value="@{
                              var org_list = ((string) context.Variables["ftp_organization"]).Split(',');
                              var org_fiscal_code = (string) context.Variables["identificativoDominio"];
                              var is_ftp_enabled = Array.Exists(org_list, e => e == org_fiscal_code);
                              return is_ftp_enabled;
                              }" />
                <set-backend-service base-url="${base-url}" />
            </when>
        </choose>
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
        <choose>
            <when condition="@(context.Variables.GetValueOrDefault<bool>("is-ftp-enabled", false) )">
                <return-response>
                    <set-header name="Content-Type" exists-action="override">
                        <value>text/xml</value>
                    </set-header>
                    <set-body template="liquid">
                        <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ppt="http://ws.pagamenti.telematici.gov/" xmlns:tns="http://NodoPagamentiSPC.spcoop.gov.it/servizi/PagamentiTelematiciRPT" xmlns:ppthead="http://ws.pagamenti.telematici.gov/ppthead">
                            <soapenv:Body>
                                <ppt:nodoChiediFlussoRendicontazioneRisposta/>
                            </soapenv:Body>
                        </soapenv:Envelope>
                    </set-body>
                </return-response>
            </when>
        </choose>
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
