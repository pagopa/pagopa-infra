<policies>
    <inbound>
        <base />
        <set-variable name="enable_fdr_ci_soap_request_switch" value="{{enable-fdr-ci-soap-request-switch}}" />
        <set-variable name="is_fdr_nodo_pagopa_enable" value="@(${is-fdr-nodo-pagopa-enable})" />
        <choose>
            <when condition="@( context.Variables.GetValueOrDefault<bool>("is_fdr_nodo_pagopa_enable", false) && context.Variables.GetValueOrDefault<string>("enable_fdr_ci_soap_request_switch", "").Equals("true") )">

              <!-- ##### START CACHE RETRIEVE PROCESS - READ PHASE #### -->

              <!-- Extracting values for fields domainId, station and PSP -->
              <set-variable name="readrequest" value="@(context.Request.Body.As<string>(preserveContent: true))" />

              <!-- Cache feature flag -->
              <set-variable name="enable_fdr_nodoChiediElenco_cache_flag" value="{{enable-fdr-nodoChiediElenco-cache-flag}}" />

              <when condition="@(context.Variables.GetValueOrDefault<string>("enable_fdr_nodoChiediElenco_cache_flag", "").Equals("true") )">
                <!-- Generating cache key in format fdr::fase1::cachereq::brokerId-stationId-domainId-pspId, then read it from internal cache -->
                <set-variable name="cached_response_key" value="@{
                  var dom2parse = ((string) context.Variables["readrequest"]);

                  String[] tagBrokerId = {"identificativoIntermediarioPA"};
                  String[] result = dom2parse.Split(tagBrokerId, StringSplitOptions.RemoveEmptyEntries);
                  String brokerId = result.Length > 2 ? result[1].Substring(1,result[1].Length-3).Replace("xmlns=\"\">", "") : "ND";

                  String[] tagStationId = {"identificativoStazioneIntermediarioPA"};
                  result = dom2parse.Split(tagStationId, StringSplitOptions.RemoveEmptyEntries);
                  String stationId = result.Length > 2 ? result[1].Substring(1,result[1].Length-3).Replace("xmlns=\"\">", "") : "ND";

                  String[] tagDomainId = {"identificativoDominio"};
                  result = dom2parse.Split(tagDomainId, StringSplitOptions.RemoveEmptyEntries);
                  String domainId = result.Length > 2 ? result[1].Substring(1,result[1].Length-3).Replace("xmlns=\"\">", "") : "ND";

                  String[] tagPspId = {"identificativoPSP"};
                  result = dom2parse.Split(tagPspId, StringSplitOptions.RemoveEmptyEntries);
                  String pspId = result.Length > 2 ? result[1].Substring(1,result[1].Length-3).Replace("xmlns=\"\">", "") : "ND";

                  return "fdr::fase1::cachereq::" + brokerId + "-" + stationId + "-" + domainId + "-" + pspId;
                }" />
              </when>
              <cache-lookup-value variable-name="fdr_cached_response_uuid" key="@((string) context.Variables["cached_response_key"])" caching-type="internal" default-value="NONE"/>

              <!-- If cached response UUID exists, it's time to search the cached response in blob-storage -->
              <choose>
                <when condition="@( !"NONE".Equals((string) context.Variables["fdr_cached_response_uuid"]) )">

                  <!-- Execute a GET call on blob-storage using the UUID as "search filter" -->
                  <authentication-managed-identity resource="https://storage.azure.com/" output-token-variable-name="msi-access-token" ignore-error="false" />
                  <send-request mode="new" response-variable-name="cached_response_content" timeout="300" ignore-error="true">
                    <set-url>@{ return "https://{{fdr_cachedresponse_saname}}.blob.core.windows.net/" + "{{fdr_cachedresponse_containername}}" + "/" + ((string) context.Variables["fdr_cached_response_uuid"]) + ".xml"; }</set-url>
                    <set-method>GET</set-method>
                    <set-header name="Host" exists-action="override">
                      <value>{{fdr_cachedresponse_saname}}.blob.core.windows.net</value>
                    </set-header>
                    <set-header name="X-Ms-Blob-Type" exists-action="override">
                      <value>BlockBlob</value>
                    </set-header>
                    <set-header name="X-Ms-Version" exists-action="override">
                      <value>2019-12-12</value>
                    </set-header>
                    <set-header name="Accept" exists-action="override">
                      <value>*/*</value>
                    </set-header>
                    <set-header name="Authorization" exists-action="override">
                      <value>@("Bearer " + (string) context.Variables["msi-access-token"])</value>
                    </set-header>
                  </send-request>

                  <!-- If a valid blob content is found in blob-storage, return the response and the related headers -->
                  <!-- This check is required because the persistence on blob-storage (made in async way) can end unsuccessfully and the cached key is stored anyway. -->
                  <choose>
                    <when condition="@(context.Variables["cached_response_content"] != null && ((IResponse) context.Variables["cached_response_content"]).StatusCode == 200)">
                      <!-- Log a little tracing message and generate the response with headers and content -->
                      <trace source="cached_content_found_on_blobstorage" severity="information">
                        <message>@{ return "BLOB content found for cached response with UUID [" + ((string) context.Variables["fdr_cached_response_uuid"]) + "]"; }</message>
                      </trace>
                      <set-variable name="cached_response_blob" value="@(((IResponse) context.Variables["cached_response_content"]).Body.As<string>())" />
                      <set-variable name="cached_response_status_code" value="@(((IResponse) context.Variables["cached_response_content"]).Headers.GetValueOrDefault("x-ms-meta-responsestatuscode", "200"))" />
                      <set-variable name="cached_response_status_reason" value="@(((IResponse) context.Variables["cached_response_content"]).Headers.GetValueOrDefault("x-ms-meta-responsestatusreason", "OK"))" />
                      <set-variable name="cached_response_content_type" value="@(((IResponse) context.Variables["cached_response_content"]).Headers.GetValueOrDefault("x-ms-meta-responsecontenttype", "text/xml"))" />
                      <return-response>
                        <set-status code="@(Convert.ToInt32(context.Variables["cached_response_status_code"]))" reason="@((string) context.Variables["cached_response_status_reason"])" />
                        <set-header name="Content-Type" exists-action="override">
                          <value>@((string) context.Variables["cached_response_content_type"])</value>
                        </set-header>
                        <set-body>@((string) context.Variables["cached_response_blob"])</set-body>
                      </return-response>
                    </when>
                    <!-- If no valid blob content is found in blob-storage, at least log an error and continue processing request -->
                    <otherwise>
                      <trace source="cached_content_not_found_on_blobstorage" severity="error">
                        <message>@{ return "No valid BLOB content found for cached response with UUID [" + ((string) context.Variables["fdr_cached_response_uuid"]) + "]"; }</message>
                      </trace>
                    </otherwise>
                  </choose>

                </when>
              </choose>

              <!-- ##### END CACHE RETRIEVE PROCESS - READ PHASE #### -->

              <set-backend-service base-url="${base-url}" />
            </when>
        </choose>
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />

        <!-- ##### START CACHE RETRIEVE PROCESS - WRITE PHASE #### -->

        <set-variable name="response_body_to_cache" value="@(((IResponse) context.Response).Body.As<string>(preserveContent: true))" />
        <set-variable name="is_in_error" value="@{
          try {
            var dom2parse = ((string) context.Variables["response_body_to_cache"]);
            String[] tagFaultCode = {"faultCode"};
            String[] result = dom2parse.Split(tagFaultCode, StringSplitOptions.RemoveEmptyEntries);
            return result.Length > 0 && result[1].Substring(1,result[1].Length-3) != null;
          } catch (Exception e) {
            return false;
          }
        }" />

        <choose>
          <when condition="@(!context.Variables.GetValueOrDefault<bool>("is_in_error", false))">

            <!-- Extracting all needed variables from response in order to use them on BLOB content file -->
            <set-variable name="response_status_code_to_cache" value="@(((IResponse) context.Response).StatusCode)" />
            <set-variable name="response_content_type_to_cache" value="@(((IResponse) context.Response).Headers.GetValueOrDefault("Content-Type", "text/xml"))" />
            <set-variable name="response_status_reason_to_cache" value="@(((IResponse) context.Response).StatusReason)" />

            <!-- Generate the UUID value in order to be used for BLOB identifier -->
            <set-variable name="fdr_cached_response_uuid_value" value="@{ return System.Guid.NewGuid().ToString(); }" />

            <!-- Store generated key with UUID value for GET phase -->
            <cache-store-value key="@((string) context.Variables["cached_response_key"])" value="@((string) context.Variables["fdr_cached_response_uuid_value"])" caching-type="internal" duration="{{fdr1_cache_duration}}" />

            <!-- Finally, send response in BLOB storage in asyncronous way. If an error occurred during persistence, -->
            <!-- in read phase the absence of BLOB file is considered equivalent to no-cached-response, so the request is sent to backend.  -->
            <authentication-managed-identity resource="https://storage.azure.com/" output-token-variable-name="msi-access-token" ignore-error="true" />
            <send-one-way-request mode="new" timeout="300">
              <set-url>@{ return "https://{{fdr_cachedresponse_saname}}.blob.core.windows.net/" + "{{fdr_cachedresponse_containername}}" + "/" + ((string) context.Variables["fdr_cached_response_uuid_value"]) + ".xml"; }</set-url>
              <set-method>PUT</set-method>
              <set-header name="Host" exists-action="override">
                <value>{{fdr_cachedresponse_saname}}.blob.core.windows.net</value>
              </set-header>
              <set-header name="X-Ms-Blob-Type" exists-action="override">
                <value>BlockBlob</value>
              </set-header>
              <set-header name="X-Ms-Blob-Cache-Control" exists-action="override">
                <value />
              </set-header>
              <set-header name="X-Ms-Blob-Content-Disposition" exists-action="override">
                <value />
              </set-header>
              <set-header name="X-Ms-Blob-Content-Encoding" exists-action="override">
                <value />
              </set-header>
              <set-header name="X-Ms-Blob-Content-Language" exists-action="override">
                <value />
              </set-header>
              <set-header name="X-Ms-Version" exists-action="override">
                <value>2019-12-12</value>
              </set-header>
              <set-header name="Accept" exists-action="override">
                <value>text/xml</value>
              </set-header>
              <set-header name="Authorization" exists-action="override">
                <value>@("Bearer " + (string)context.Variables["msi-access-token"])</value>
              </set-header>
              <!-- Setting the custom headers, required for cached response -->
              <set-header name="x-ms-meta-responsestatuscode" exists-action="override">
                <value>@(((int) context.Variables["response_status_code_to_cache"]).ToString())</value>
              </set-header>
              <set-header name="x-ms-meta-responsestatusreason" exists-action="override">
                <value>@((string) context.Variables["response_status_reason_to_cache"])</value>
              </set-header>
              <set-header name="x-ms-meta-responsecontenttype" exists-action="override">
                <value>@((string) context.Variables["response_content_type_to_cache"])</value>
              </set-header>
              <!-- Set the file content from the original request body data -->
              <set-body>@((string) context.Variables["response_body_to_cache"])</set-body>
            </send-one-way-request>
          </when>
          <!-- If no valid blob content is found in blob-storage, at least log an error and continue processing request -->
          <!--<otherwise>
            <trace source="response_not_cached_for_error" severity="information">
              <message>@{ return "Not caching response because the response returned a fault code."; }</message>
            </trace>
          </otherwise>-->
        </choose>

        <!-- ##### END CACHE RETRIEVE PROCESS - WRITE PHASE #### -->
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
