prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "portalpa"
location_short = "itn"
location       = "italynorth"

app_service_sku_name        = "P1v3"
app_service_slot_enabled    = true
next_public_app_url_staging = "https://pagopa-p-itn-portalpa-app-staging.azurewebsites.net"

container_image_name   = "pagopapcommonacr.azurecr.io/pagopa-portal:latest"
postgres_database_name = "dipartimento_pagamenti"
next_public_app_url    = "https://pagopa-p-itn-portalpa-app.azurewebsites.net"
email_public_app_url   = "https://pagopa-p-itn-portalpa-app.azurewebsites.net"

aws_region              = "eu-south-1"
email_fallback_provider = "none"
email_provider          = "onemail"

github_issues_owner = "pagopa"
github_issues_repo  = "pagopa-payments-department-centralhub"

onemail_base_url    = "https://onemail.pagopa.it"
onemail_env         = "prod"
onemail_from_email  = "noreply@internal-apps.platform.pagopa.it"
onemail_tenant_name = "PROD"

timetrack_email_disable_send = false
timetrack_email_force_to     = "cristiano.sticca@pagopa.it"
timetrack_onemail_from_email = "noreply@internal-apps.platform.pagopa.it"

training_email_disable_send = false
training_email_force_to     = "cristiano.sticca@pagopa.it"
training_onemail_from_email = "noreply@internal-apps.platform.pagopa.it"

websites_enable_app_service_storage = false
