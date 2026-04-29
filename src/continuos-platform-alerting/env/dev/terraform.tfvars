env_short      = "d"
location_short = "itn"



custom_action_group = {
    default = [
      {
        action_group_name    = "PagoPA"
      },
      {
        action_group_name    = "SlackPagoPA"
      }
    ],
    pagopa-d-redis = [
      {
        action_group_name    = "SlackPagoPA"
      },
      {
        action_group_name    = "PagoPA"
      }
    ]
}