<fragment>
  <set-variable name="is_perf_env" value="@{
    if (((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Equals("api.prf.platform.pagopa.it") || ((string)context.Request.OriginalUrl.ToUri().Host).Equals("api.prf.platform.pagopa.it")) {
      return true;
    }
    return false;
  }" />
  ${content}
</fragment>
