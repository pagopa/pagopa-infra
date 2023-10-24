<policies>
  <inbound>
    <set-body>
      <html>
        <body>
          <script>
            const fragment = window.location.hash.slice(1);
            const requestBody = new URLSearchParams(fragment);

            fetch(${pm_webview_path}, {
              method: "POST",
              headers: {
                "Content-Type": "application/x-www-form-urlencoded",
              },
              referrerPolicy: "no-referrer",
              body: requestBody,
            });
          </script>
        </body>
      </html>
    </set-body>
  </inbound>

  <outbound>
    <base />
  </outbound>

  <backend>
      <base />
  </backend>
</policies>
