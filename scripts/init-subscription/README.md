# init-subscription

Inizialize subscription with following operations:
1. register `Microsoft.Storage` provider
1. create storage account for app terraform state without sensitive data (naming convention `tfapp<subscriptionname>`)
1. create storage account for infrastructure terraform state with possibile sensitive data (naming convention `tfinf<subscriptionname>`)

```sh
./run.sh SUBSCRIPTION-NAME
```
