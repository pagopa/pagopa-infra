<policies>
    <inbound>
        <base />


        <return-response>
            <set-status code="200" reason="OK"/>
            <set-header name="Content-Type" exists-action="override">
                <value>text/xml</value>
            </set-header>
            <set-body>@{
                return @"<?xml version=""1.0"" encoding=""UTF-8"" standalone=""no"" ?>
                <soapenv:Envelope xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:soapenv=""http://schemas.xmlsoap.org/soap/envelope/"" xmlns:bc=""http://PuntoAccessoPSP.spcoop.gov.it/BarCode_GS1_128_Modified"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"" xmlns:pay_i=""http://www.digitpa.gov.it/schemas/2011/Pagamenti/"" xmlns:ppt=""http://ws.pagamenti.telematici.gov/"" xmlns:tns=""http://PuntoAccessoPSP.spcoop.gov.it/servizi/PagamentiTelematiciPspNodo"" xmlns:qrc=""http://PuntoAccessoPSP.spcoop.gov.it/QrCode"">
                <soapenv:Body>
                    <ppt:nodoChiediElencoFlussiRendicontazioneRisposta>
                        <fault>
                            <faultCode>PPT_SYSTEM_ERROR</faultCode>
                            <faultString>Sistema in aggiornamento.</faultString>
                            <id>NodoDeiPagamentiSPC</id>
                            <description>Sistema in aggiornamento</description>
                        </fault>
                        <esito>KO</esito>
                    </ppt:nodoChiediElencoFlussiRendicontazioneRisposta>
                </soapenv:Body>
            </soapenv:Envelope>";
            }</set-body>
    </return-response>


        <set-variable name="enable_fdr_ci_soap_request_switch" value="{{enable-fdr-ci-soap-request-switch}}" />
        <set-variable name="is_fdr_nodo_pagopa_enable" value="@(${is-fdr-nodo-pagopa-enable})" />
        <choose>
            <when condition="@( context.Variables.GetValueOrDefault<bool>("is_fdr_nodo_pagopa_enable", false) && context.Variables.GetValueOrDefault<string>("enable_fdr_ci_soap_request_switch", "").Equals("true") )">
              <set-variable name="readrequest" value="@(context.Request.Body.As<string>(preserveContent: true))" />
              <set-backend-service base-url="${base-url}" />
            </when>
        </choose>
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
