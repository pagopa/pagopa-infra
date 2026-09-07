prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "portalpa"
location_short = "itn"
location       = "italynorth"

container_image_name   = "pagopadcommonacr.azurecr.io/pagopa-portal:latest"
postgres_database_name = "dipartimento_pagamenti"
next_public_app_url    = "https://pagopa-d-itn-portalpa-app.azurewebsites.net"
email_public_app_url   = "https://pagopa-d-itn-portalpa-app.azurewebsites.net"

aws_region              = "eu-south-1"
email_fallback_provider = "none"
email_provider          = "onemail"

github_issues_owner = "pagopa"
github_issues_repo  = "pagopa-payments-department-centralhub"

onemail_base_url    = "https://uat.onemail.pagopa.it"
onemail_env         = "uat"
onemail_from_email  = "noreply@uat.internal-apps.platform.pagopa.it"
onemail_tenant_name = "TEST"

timetrack_email_disable_send = false
timetrack_email_force_to     = "cristiano.sticca@pagopa.it"
timetrack_onemail_from_email = "noreply@uat.internal-apps.platform.pagopa.it"

training_email_disable_send = false
training_email_force_to     = "cristiano.sticca@pagopa.it"
training_onemail_from_email = "noreply@uat.internal-apps.platform.pagopa.it"

websites_enable_app_service_storage = false
