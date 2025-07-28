package it.pagopa.opa.terraform.version

import input as tfplan
import rego.v1

minimum_terraform := "1.11.0"

deny contains msg if {
    v := tfplan.terraform_version
    semver.compare(v, minimum_terraform) < 0

    msg := sprintf("terraform version must be at least %v - %v is not supported", [minimum_terraform, v])
}