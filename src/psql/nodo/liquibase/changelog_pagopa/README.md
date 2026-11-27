# Database migration via Liquibase

## Preconditions
The essential prerequisite for running the database schema update pipelines is that the PGFlex servers must already be
installed and operational. The [migration pipeline](https://dev.azure.com/pagopaspa/pagoPA-iac/_build?definitionId=2207) 
applies the changes defined in `changelog_pagopa` folder.

## Changelogs
The tables below summarize the changes included by each database's Liquibase master changelog. 
The Database, Schema, and User columns show the values passed to Liquibase by the migration pipeline; 
individual changesets may create objects in other schemas.

The following section outlines the changelog for the versioned releases of the database on its related schemas.  
For each version, it describes a list of the changes that version would introduce to the current structure.

### Schema `public`
| Version | Schema | User      | Description                                                                                                        |
|---------|--------|-----------|--------------------------------------------------------------------------------------------------------------------|
| 1.0.0   | public | azureuser | _No change_                                                                                                        |
| 1.1.0   | public | azureuser | _No change_                                                                                                        |
| 1.2.0   | public | azureuser | <ul><li>Scheduling `cfg.cfg_cache_purge()` daily at 04:00;</li></ul>                                               |
| 1.3.0   | public | azureuser | <ul><li>Scheduling daily deletion of `offline.scheduler_fire_check` records older than 30 days at 03:15;</li></ul> |

### Schema `cfg`
| Version | Schema | User | Description                                                                                                                                 |
|---------|--------|------|---------------------------------------------------------------------------------------------------------------------------------------------|
| 1.0.0   | cfg    | cfg  | _No change_                                                                                                                                 |
| 1.1.0   | cfg    | cfg  | _No change_                                                                                                                                 |
| 1.2.0   | cfg    | cfg  | <ul><li>Adding `cfg.cfg_cache_purge` procedure to remove old cache records by date or TTL while retaining at least seven records;</li></ul> |
| 1.3.0   | cfg    | cfg  | _No change_                                                                                                                                 |

### Schema `online`
| Version | Schema | User   | Description                                                                                                                                       |
|---------|--------|--------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| 1.0.0   | online | online | <ul><li>Granting `offline` SELECT access to `POSITION_TRANSFER`, `RT_VERSAMENTI`, `PM_SESSION_DATA`, `RT`, `RPT`, and `RPT_VERSAMENTI`;</li></ul> |
| 1.1.0   | online | online | _No change_                                                                                                                                       |
| 1.2.0   | online | online | _No change_                                                                                                                                       |
| 1.3.0   | online | online | <ul><li>Adding `offline.get_retry_queues()` to report retry counts, oldest item and age, and maximum retry for the online retry queues;</li></ul> |

### Schema `offline`
| Version | Schema  | User    | Description                                                                                                                                                                                |
|---------|---------|---------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1.0.0   | offline | offline | _No change_                                                                                                                                                                                |
| 1.1.0   | offline | offline | _No change_                                                                                                                                                                                |
| 1.2.0   | offline | offline | _No change_                                                                                                                                                                                |
| 1.3.0   | offline | offline | <ul><li>Adding `offline.get_cron_monitoring` to report recent cron job execution status and timing;</li><li>Adding `offline.get_running_workers` to report long-running workers;</li></ul> |

### Schema `re`
| Version | Schema | User      | Description                                                          |
|---------|--------|-----------|----------------------------------------------------------------------|
| 1.0.0   | re     | azureuser | _No change_                                                          |
| 1.1.0   | re     | azureuser | <ul><li>Setting storage for `re.re.payload` to `EXTENDED`;</li></ul> |
| 1.2.0   | re     | azureuser | _No change_                                                          |
| 1.3.0   | re     | azureuser | _No change_                                                          |
